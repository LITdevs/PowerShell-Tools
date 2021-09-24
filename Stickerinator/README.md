# Stickerinator

The Stickerinator allows you to create Discord-compatible stickers from GIFs.

Discord's arbitrary limitations are very confusing and hard to remember, and tedious to resolve.

Please note that quality is not currently considered a priority, as this tool is mainly used by Vukky to create meme stickers.

## Features

* Resizes GIF if needed (may not work - Discord recommends stickers to be 320x320)
* Cuts GIF if needed (Discord stickers must not be longer than 5 seconds)
* Compresses GIF if needed (Discord stickers must not be above 500 KB)
* Creates an APNG from the GIF (Discord uses the APNG format)

## Usage

No file extensions are required, as the Stickerinator can only create APNGs from GIFs.

```powershell
./stickerinator.ps1 -i <input_file> -o <output_file>
```

### Optional parameters

If you want the Stickerinator to keep the GIF instead of the APNG if the file size requirement is not met, you can use the `-keepgif` parameter.

You can set the width of the outputted APNG like this: `-width 256`. By default, this is set to `320`.

You can set the lossy compression levels like this: `-lossy 125`. By default, this is set to `200` (maximum compression). This only takes effect if Gifsicle decides that lossy compression would be optimal.

### Dependencies

The Stickerinator requires [Gifsicle](http://www.lcdf.org/gifsicle/) and [gif2apng CLI](https://sourceforge.net/projects/gif2apng/files/) to be in PATH.
