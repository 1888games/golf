enum { BLACK,WHITE,RED,CYAN,VIOLET,GREEN,BLUE,YELLOW,ORANGE,BROWN,LIGHT_RED,
    GREY1,GREY2,LIGHT_GREEN,LIGHT_BLUE,GREY3 };
array(string) color_names = ({ "black","white","red","cyan","violet","green",
    "blue","yellow","orange","brown","light red","grey1","grey2","light green",
    "light blue","grey3" });
array RGB = ({
    ({ 0,0,0 }),
    ({ 255,255,255 }),
    ({ 104,55,43 }),
    ({ 112,164,178 }),
    ({ 111,61,134 }),
    ({ 88,141,67 }),
    ({ 53,40,121 }),
    ({ 184,199,111 }),
    ({ 111,79,37 }),
    ({ 67,57,0 }),
    ({ 154,103,89 }),
    ({ 68,68,68 }),
    ({ 108,108,108 }),
    ({ 154,210,132 }),
    ({ 108,94,181 }),
    ({ 149,149,149 })
});

// Actual data that will be written to binary output file.
array(int) bitmap = ({});
array(int) color_ram = ({});
array(int) video_ram = ({});

// NOTE: if you want to force any particular C64 color to use a particular
// code, define them here (C64 color -> color code).
mapping(int:int) color_code_constraints = ([ ORANGE:0,BLACK:3,WHITE:1,GREY3:2 ]);
// NOTE: also set the b/g color here!
constant BG_COLOR = ORANGE;
// NOTE: set to -1 if don't want forced color map on all cells.
//constant VRAM_CELLS = (GREY2<<4)|GREY3;
//constant CRAM_CELLS = GREY1;
constant VRAM_CELLS = WHITE<<4|GREY3;    //-1;    //(GREY1<<4)|WHITE;
constant CRAM_CELLS = BLACK;// -1;    //GREY3;
constant ASSETS_DIR = "../../assets/pictures";
constant DEST_X_PIXELS = 1*4;
constant DEST_Y_PIXELS = 17*8;

int icon_w_chars;
int icon_h_chars;
array(mapping) all_icons = ({});

int main(int argc, array(string) argv)
{
    string filename_in = sprintf("%s/slope_box4.png", ASSETS_DIR);
    string filename_out = sprintf("%s/slope_box.bin", ASSETS_DIR);
    icon_w_chars = 3;

    string data = Image.load_file(filename_in);
    object img = Image.PNG.decode(data);
    write("dimensions=%d*%d\n", img->xsize(), img->ysize());
    icon_h_chars = img->ysize() / 8;
    //int num_icons = img->xsize() / (icon_w_chars*8);
    //write("num_icons=%d\n", num_icons);
    /*
    for (int i = 0; i < num_icons; ++i)
    {
        process_icon(i, img);
    } // for
    */
    process_icon(img);
    refine_colors();
    write_output(filename_out);

    return 0;

} // main()

void process_icon(object img)
{
    mapping m = ([]);
    // Clear out global arrays.
    bitmap = ({});
    color_ram = ({});
    video_ram = ({});

    // Process 8 bytes (i.e. one character) at a time...
    for (int row_iter = 0; row_iter < icon_h_chars; ++row_iter)
    {
        for (int col_iter = 0; col_iter < icon_w_chars; ++col_iter )
        {
            process_8_bytes(img, row_iter, col_iter);
        } // for
    } // for

    m["bitmap"] = bitmap;
    m["colram"] = color_ram;
    m["vidram"] = video_ram;

    all_icons += ({ m });

} // process_icon()

void process_8_bytes(object img, int row_iter, int col_iter)
{
    ADT.Set my_colors = ADT.Set();

    // First, find out where we're going to be getting pixel data from (- from
    // the original PNG image).
    int start_x = col_iter * 8;
    int start_y = row_iter * 8;
    int x = start_x;
    int y = start_y;
    //write("\n\n\n*****----->  x=%d,y=%d (%d)\n", start_x, start_y, i);
    
    // NOTE: j counts rows, k counts columns (4 per byte!).
    // Here we are just going to collect whatever colors we find in the 
    // char and put them in the set, 'my_colors' (excluding the given b/g
    // color).
    for (int j = 0; j < 8; ++j)
    {
        for (int k = 0; k < 4; ++k)
        {
            // Get the next pixel and find its C64 color.
            array rgb = img->getpixel(x, y);
            int c64color = lookup_color(rgb);
            write("*** %d(%d,%d)\n", c64color, x, y);
            if (c64color != BG_COLOR)
            {
                my_colors->add(c64color);
            } // if
            x += 2;
        } // for
        // Prepare for the next byte.
        x = start_x;
        ++y;
    } // for

    // Now populate the 'char_colors' array with these found colors.  The index
    // of each color also indicates which color code it should be assigned to.
    array char_colors = allocate(4, 0);
    char_colors[0] = BG_COLOR;
    array a = indices(my_colors);
    write("how many? %d (%d,%d)\n%O\n", sizeof(a), row_iter, col_iter, a);
    for (int j = 0; j < sizeof(a); ++j)
    {
        char_colors[j+1] = a[j];
    } // for
    apply_color_constraints(char_colors);

    // Record color setup for this char.
    int vram = (char_colors[1]<<4) | char_colors[2];
    int cram = char_colors[3];
    if (VRAM_CELLS >= 0) { vram = VRAM_CELLS; }
    if (CRAM_CELLS >= 0) { cram = CRAM_CELLS; }
    video_ram += ({ vram });
    color_ram += ({ cram });

    show_colors(char_colors);

    // Once more to record the pixel data.
    x = start_x;
    y = start_y;
    for (int j = 0; j < 8; ++j)
    {
        int mybyte = 0;
        for (int k = 0; k < 4; ++k)
        {
            array rgb = img->getpixel(x, y);
            int c64color = lookup_color(rgb);
            int cc = search(char_colors, c64color);
            mybyte += (cc << (6-(k*2)));
            x += 2;
        } // for
        bitmap += ({ mybyte });
        x = start_x;
        ++y;
    } // for

} // process_8_bytes()

int lookup_color(array(int) rgb)
{
    for (int i = 0; i < sizeof(RGB); ++i)
    {
        array a = RGB[i];
        if ( equal(a, rgb) ) //rgb[0]==a[0] && rgb[1]==a[1] && rgb[2]==a[2] )
        {
            return i;
        } // if
    } // for

    werror("Invalid color! %O\n", rgb);
    exit(1);

} // lookup_color()

void apply_color_constraints(array colors)
{
    // If same colors applied universally, just use 'color_code_constraints'
    // mapping as the colors array!
    // NOTE: there should be four entries in the mapping!!!
    if (VRAM_CELLS >=0 && CRAM_CELLS >= 0)
    {
        foreach (indices(color_code_constraints), int c)
        {
            colors[ color_code_constraints[c] ] = c;
        } // foreach
        return;
    } // if


    foreach (indices(color_code_constraints), int c)
    {
        // Is this color in the current char?
        int from = search(colors, c);
        if (from >= 0)
        {
            int to = color_code_constraints[c];
            if (from != to)
            {
                // Do swap.
                int temp = colors[to];
                colors[to] = colors[from];
                colors[from] = temp;
            } // if
        } // if
    } // foreach

} // apply_color_constraints()

void write_output(string filename_out)
{
    Stdio.File fout = Stdio.File(filename_out, "wct");

    mapping m = all_icons[0];
    fout->write("%s", (string) ({ DEST_Y_PIXELS, DEST_X_PIXELS }));
    fout->write("%s", (string) ({icon_h_chars, icon_w_chars}));
    fout->write("%s", (string) ({sizeof(m["vidram"])}));
    fout->write("%s", (string) m["bitmap"]);
    fout->write("%s", (string) m["vidram"]);
    fout->write("%s", (string) m["colram"]);

    fout->close();

} // write_output()

void show_colors(array a)
{
    write("--->\n");
    for (int i = 0; i < sizeof(a); ++i)
    {
        write("%d = %s\n", i, color_names[ a[i] ]);
    } // for

} // show_colors()

void refine_colors()
{
    mapping m = all_icons[0];
    m["vidram"][9] = GREY3;
    m["vidram"][10] = GREY3;
    m["vidram"][11] = GREY3;
    m["vidram"][12] = GREY2;
    m["vidram"][13] = GREY2;
    m["vidram"][14] = GREY2;
    m["vidram"][15] = (GREY1<<4)|GREY1;
    m["vidram"][16] = (GREY1<<4)|GREY1;
    m["vidram"][17] = (GREY1<<4)|GREY1;

} // refine_colors()







