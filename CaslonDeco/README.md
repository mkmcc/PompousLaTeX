# Pompous Caslon Decorations


## Inspiration

I recently went through the
[exercise](https://github.com/mkmcc/LatexFonts) of installing nice
open-type fonts for use in pdfLaTex.  When looking at the character
table for *Caslon*, I noticed these ornament symbols, some of which
seem fairly mysterious:

![Caslon Ornaments](./Caslon-Ornaments.png)

I puzzled out how they might go together and made a latex package to
make them easier to use.  This package of course requires you to have
the font, and to have used `autoinst` to install it into your LaTeX
texmf tree.  That process is quite involved, and I'm not sure I'd
recommend it.  But if you do, you can make use of these pompous
designs.

(Pompous not to anything intrinsic in the glyphs; they seem expertly
crafted, and I'm sure it's possible to make beautiful things with
them.  Perhaps this code might enable you to do so.  But in the hands
of a philistine like me, these are the designs you get.)


## Example Business Card

```latex
  \drawtilepattern{%
    tileA=\mdbia,%
    colorA=silver,%
    tileB=\mdbia,%
    colorB=silver,%
    tileC=\mdbb,%
    colorC=silver,%
    tileD=\mdbib,%
    colorD=silver,%
    Nx=9,%
    Ny=5,%
    displaywidth=3.5in,%
    displayheight=2in%
  }

  \pompousframecentered{%
    Nx=9,%
    Ny=4,%
    position={(\cardWidth/2, \cardHeight/2)},
    text={\textsw{Pompous Extr. Maximus, Ph.D.}\\
      \textsc{Piled Higher} \textsw{\&} \textsc{Deeper}\\
      \textsw{minted} 2014},
      background=white
  }

```

![Card Front](./png/card-front.png)

```latex
  \drawxgrid{%
    Nx=21,%
    Ny=12,%
    displaywidth=3.5in,
    displayheight=2in,
    color=black!40!white,
    yshift=0.5,
    flrmodval=3,
    initial={\footnotesize \textsw{b}}
  }

  \dotframecentered{%
    Nx=11,
    Ny=3,
    text={
      \textsc{Bailey-``Bob'' McCourt} \\
      \textsw{adventurer}
    },
    position={(\cardWidth/2, \cardHeight/2)},
    background=black!2!white,
  }

```

![Alternate Card Front](./png/altcard-front.png)

```latex
  \drawxgrid{%
    Nx=21,%
    Ny=12,%
    displaywidth=3.5in,
    displayheight=2in,
    color=black!40!white,
    yshift=0.5,
    flrmodval=4,
    xshift=1.0, 
    initial={\footnotesize \textsw{A}}
  }

  \filldraw[
    fill=black!2!white,
    draw=black,
    style=double,
    double distance=2pt,
    line width=0.8pt
  ]
  (0.15*\cardWidth,\cardHeight/2)
  -- (0.5*\cardWidth,0.9*\cardHeight)
  -- (0.85*\cardWidth,\cardHeight/2)
  -- (0.5*\cardWidth,0.1*\cardHeight)
  -- cycle;

  \node[draw=none, align=center, yshift=-3pt] at (\cardWidth/2, \cardHeight/2) (ctr) {
    \Telefon \;\; (123) 456-789 \\
    \Letter \;\; 5 Wallowing Dove Ln \\
    \faBriefcase \;\; \textit{Chief Good Times Officer} \\
    \Industry \;\; Ministry of Recreation \\
    \Football \;\; Thursdays @ 5pm \\
    \Lightning
  }; 

```

![Card Back](./png/card-back.png)


## Example Grids

### plain grid

```ruby
{ }
```

![Grid 1](./png/grid_00.png)

### alternate in decorated x's

```ruby
{ modval: 1 }
```

![Grid 2](./png/grid_01.png)

```ruby
{ modval: 2 }
```

![Grid 3](./png/grid_02.png)

```ruby
{ modval: 3, xshift: 2.0 }
```

![Grid 4](./png/grid_03.png)

```ruby
{ modval: 4 }
```

### alternate in florins

![Grid 5](./png/grid_04.png)

```ruby
{ flrmodval: 1, modval: 1 }
```

![Grid 6](./png/grid_05.png)

```ruby
{ flrmodval: 1 }
```

![Grid 7](./png/grid_06.png)

```ruby
{ flrmodval: 2, xshift: 1.0 }
```

![Grid 8](./png/grid_07.png)

```ruby
{ flrmodval: 3, xshift: 3.0 }
```

![Grid 9](./png/grid_08.png)

```ruby
{ flrmodval: 3, xshift: 6.0 }
```

![Grid 10](./png/grid_09.png)

```ruby
{ flrmodval: 4, xshift: 1.0 }
```

### add initials

![Grid 11](./png/grid_10.png)

```ruby
{ flrmodval: 2, xshift: 1.0, initial: '{b}' }
```

![Grid 12](./png/grid_11.png)

```ruby
{ flrmodval: 4, xshift: 1.0, initial: '{\\footnotesize \\textsw{A}}' }
```

![Grid 13](./png/grid_12.png)


## Example Tiles

```ruby
  {
    tileA: "\\mdbia", colorA: "silver",
    tileB: "\\mdbb",  colorB: "paledogwood",
    tileC: "\\mdba",  colorC: "resedagreen",
    tileD: "\\mdba",  colorD: "cambridgeblue"
  }
```

![Tile 1](./png/tile_00.png)

```ruby
  {
    tileA: "\\mdbie", colorA: "silver",
    tileB: "\\mdbie", colorB: "silver",
    tileC: "\\mdbe",  colorC: "black!30!silver",
    tileD: "\\mdbe",  colorD: "black!30!silver"
  }
```

![Tile 2](./png/tile_01.png)

```ruby
  {
    tileA: "\\mdbb",  colorA: "silver",
    tileB: "\\mdbia", colorB: "silver",
    tileC: "\\mdbd",  colorC: "resedagreen",
    tileD: "\\mdbd",  colorD: "resedagreen"
  }
```

![Tile 3](./png/tile_02.png)

```ruby
  {
    tileA: "\\mdba",  colorA: "silver",
    tileB: "\\mdbia", colorB: "silver",
    tileC: "\\mdbb",  colorC: "silver",
    tileD: "\\mdbib", colorD: "silver"
  }
```

![Tile 4](./png/tile_03.png)

```ruby
  {
    tileA: "\\mdbhx", colorA: "silver",
    tileB: "\\mdbihx",colorB: "silver",
    tileC: "\\mdbb",  colorC: "silver",
    tileD: "\\mdbib", colorD: "silver"
  },
```

![Tile 5](./png/tile_04.png)

```ruby
  {
    tileA: "\\mdbc",  colorA: "silver",
    tileB: "\\mdbic", colorB: "silver",
    tileC: "\\mdbd",  colorC: "silver",
    tileD: "\\mdbid", colorD: "silver"
  }
```

![Tile 6](./png/tile_05.png)
