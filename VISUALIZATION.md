## Background

This is how I typically make GIFs and videos. The first step is always
frames, and my tool of choice is [node-canvas](https://github.com/LearnBoost/node-canvas)
because it's relatively simple and fast.

Since you're painting lots of frames, rendering can be time-intensive. Rules
of thumb for rendering fast with Canvas:

* Round your pixels. Never draw on the half pixel. Use `~~` to make this small and fast.
* Minimize changes to your palette - touching `fillStyle` and `strokeStyle` is _extremely performance intensive_.

## GIFs

Tools:

    brew install gifsicle
    # GraphicsMagick recommended, imagemagick also works
    brew install graphicsmagick

Aliases:

    # assumes graphicsmagick, otherwise drop the gm
    alias togif='gm mogrify -format gif'

Baking:

save a bunch of images. use a pad for filename, for instance:

```javascript
function pad(number, length) {
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }
    return str;
}

// and while saving files...
fs.writeFileSync('bboxes_output/bboxes_geo3_' + pad(pass++, 5) + '.png', c.toBuffer());
```

Otherwise, you will get pwned by the order of your filenames

After baking, convert to gif first:

    togif *.png

Then convert to gif:

    gifsicle --loop -d20 *.gif > ../anim.gif

## Videos

Examples: [keyss](http://vimeo.com/53993679), [osm edits](http://vimeo.com/53991791), [runs](http://vimeo.com/53026392), [centers of edits](http://vimeo.com/53021947)

Same kind of make-images thing as with GIFs, with a few diffs. Install
ffmpeg

    brew install ffmpeg

Then run it.

    ffmpeg -f image2 -i changesets_%05d.png -sameq  -vf "setpts=(2)*PTS" anim.mpg

Of note here:

    changesets_%05d.png

Says 'changesets_00000.png' and up - we're padding numbers to 5 digits and expect
them. So pad.

    setpts=(2)*PTS

Tinkering with `(2)` lets you change how many files become a frame: so you can
make videos faster or slower by changing this.

    -sameq

Says [same quantizers](http://ffmpeg.org/trac/ffmpeg/wiki/Option%20'-sameq'%20does%20NOT%20mean%20'same%20quality') and
usually gives you good quality. If you remove it, the video is usually
lower quality and larger files.

Since videos basically compress differences, highly-changing videos
will be huge and you might need to drop `-sameq`.
