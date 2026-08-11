# openomf-DarkRemix-mod
DarkRemix Mod by DeadFutureRadio for use in OpenOMF

NOTE: This README was copied from https://github.com/RileyMarquis3/openomf-music-mod/blob/main/README.md and is in the middle of being updated for my creation of the music mod with audio by DeadFutureRadio. <br>
I am NOT the author of the audio tracks!  I am simply learning how to make this mod for OpenOMF. <br>
Sadly, this mod does NOT work yet, but the audio tracks are ready for your enjoyment. <br>

### What I Have Done So Far
<ul>
  <li>Saved a copy of the original soundtrack file from https://www.youtube.com/watch?v=GLQTorm1OEw with <br> VideoDownloadHelper for Firefox (https://downloadhelper.net). </li>
  <li>Used WinFF to convert the downloaded video into audio format. </li>
  <li>Used Audacity and the Youtube Description to split the file into its relevant soundtrack files (ARENA0, etc.)</li>
  <li>Created the file/folder structure based on the forked audio mods </li>
  <li>Modified the manifest.ini files and LICENSE.txt files.</li>
</ul>

### Things I Still Need To Do
<ul>
  <li>Determine and create the loop points.</li>
  <li>Update the Makefile with the correct file names and loop points.</li>
  <li>Test the mods (not currently working for some reason!).</li>
  <li>Let DarkFutureRadio know about the mod and have it reviewed and approved.</li>
</ul>

# Soundtracks

Tracks by [**Shady Monk**](https://linktr.ee/shadymonk) (Shay.) and [**DeBisco**](https://www.debiscomusic.com/).

## Tracks

| Dir | Artist | Title | Length |
|---|---|---|---|
| MENU | DeadFutureRadio | Menu | 3:06 |
| ARENA0 | DeadFutureRadio | Arena 0 (Stadium) | 2:52 |
| ARENA1 | DeadFutureRadio | Arena 1 (Danger Room) | 3:15 |
| ARENA2 | DeadFutureRadio | Arena 2 (Power Plant) | 3:12 |
| ARENA3 | DeadFutureRadio | Arena 3 (Fire Pit) | 3:55 |
| ARENA4 | DeadFutureRadio | Arena 4 (Desert) | 2:37 |
| END | DeadFutureRadio | Ending | 3:00 |

## Building

Requirements: `ffmpeg` (with libopus), `ffmpeg-normalize` (install via python pip),
flac`, `zip`, and `git-lfs` (the flac sources are stored via LFS).

Cloning:

```
git lfs install     # one-time per user
git clone <repo>
```

Build everything:

```
make                # encode flac → ogg in each mod dir, then bundle mod zips
```

Targets:

- `make convert` — encode each `<DIR>/*.flac` → `<DIR>/audio/music/<DIR>.ogg`
  (with LOOPSTART/LOOPEND tags for ARENA0 and END)
- `make zip` — package each mod's `manifest.ini`, `LICENSE.txt`, and
  `audio/music/<DIR>.ogg` into `mod_files/<DIR>.zip`
- `make clean` — remove generated `audio/` dirs and the `mod_files/` directory

The zips in `mod_files/` are the distributable mods. Each contains
`manifest.ini` and `LICENSE.txt` at the root, plus the encoded ogg under
`audio/music/<DIR>.ogg`.

## Loop points (Not Updated Yet From Original Fork!)

Some tracks have an intro followed by a loopable section. When playback reaches
the loop end, it should jump back to the loop start (not to 0:00).

### ARENA0 — Stadium (Shady Monk)

- File: `ARENA0/Shady Monk - Stadium Remix [m1].flac`
- Intro: 0:00 – 0:42
- Loop start: ~0:42
- Loop end: end of file

Artist note (Shady Monk): Intro runs from 0:00 to 0:42. From 0:42/0:43 (the
exact frame is tempo-dependent) until the end of the file is the loopable
portion — once playback reaches the end of the file it should loop back to the
0:42 mark.

### END — Ending (DeBisco)

- File: `END/DeBisco - Ending [OST Version] [24-Bit Master] V3.flac`
- Intro: 0:00 – 0:20
- Loop start: 0:20
- Loop end: 2:33 (file fades out at 2:34)

Artist note (DeBisco): The OST version fades out at 2:34. To loop indefinitely,
set loop points at 0:20 and 2:33 so the main section loops; 0:00–0:20 is used
as the intro. Only the OST version was submitted (no separate non-fading
master).

## Licenses

Each track's license is included in its directory as `LICENSE.txt`.


## Troubleshooting

If audio mods in OpenOMF (the open-source engine for One Must Fall: 2097) are not working, it is usually caused by incorrect folder structures, missing loop tags in OGG files, or misnamed configuration manifests.  
<ul>
  
<li> Fixing OpenOMF Audio ModsCheck the Manifest: Ensure every music or sound mod contains a valid manifest.ini file in its root folder. </li> <br>

<li> Verify Audio Formats: Audio tracks must be properly encoded as .ogg files (FLAC files need to be converted before packaging). </li> <br>

<li> Loop Tags: Music tracks like arena themes require specific loop points (LOOPSTART and LOOPEND tags) encoded into the OGG metadata, or they may fail to play or loop properly. </li> <br>

<li> Correct Directory: Place the zipped mod or unpacked mod folder into the designated OpenOMF mods/ directory. </li> <br>
</ul>

## File Tags

<h5>
In OpenOMF (the open-source clone of One Must Fall 2097), LOOPSTART and LOOPEND metadata tags are used inside .ogg audio files to create seamless background music. These tags allow the game engine to play a track's introductory section exactly once, and then continuously loop a specific middle or ending section without restarting the whole song.
</h5>

### Critical Rules for OpenOMF Tags
<ul>
  <li> Unit of Measurement: Both tags must be written using exact audio sample numbers, not timestamps like seconds or minutes. </li>

  <li> Case Sensitivity: Use ALL CAPS (LOOPSTART and LOOPEND) to ensure compatibility across all source-port platforms. </li>

  <li> File Format: Ensure your modded track is exported as an Ogg Vorbis (.ogg) file. </li>
</ul>

### Step-by-Step Implementation Guide

<h5>
You can inject these metadata tags into your custom .ogg tracks using a free editor like Audacity.
</h5>
   <ul>
    <li> Find Your Points: Open your custom song in Audacity and find the exact spot where the introduction ends (where the loop should begin) and where the track loops back. </li> <br>
    <li> Switch to Samples: Change the selection bar format at the bottom of the screen from time to Samples. </li> <br>
    <li> Record the Values: Note the precise sample number for your loop starting point and your loop ending point. </li> <br>
    <li> Export the Mod File: Go to File -> Export -> Export as OGG. Name it according to the specific arena theme you are replacing (e.g., ARENA0.ogg). </li> <br>
    <li> Add Metadata Tags: In the Edit Metadata Tags window that pops up right before saving:Click Add to create a new row. Type LOOPSTART in the tag column and your start sample number in the value column. <br>
      Click Add again. Type LOOPEND in the tag column and your end sample number in the value column. </li> <br>
    <li> Save & Deploy: Click OK to finish exporting. Package your track into your OpenOMF mod subdirectory under audio/music/.  </li> <br>

</h5>
