OPUS_BITRATE := 96k
TARGET_LUFS := -16

OGGS := ARENA0/audio/music/ARENA0.ogg ARENA1/audio/music/ARENA1.ogg ARENA2/audio/music/ARENA2.ogg ARENA3/audio/music/ARENA3.ogg ARENA4/audio/music/ARENA4.ogg END/audio/music/END.ogg
ZIPS := mod_files/ARENA0.zip mod_files/ARENA1.zip mod_files/ARENA2.zip mod_files/ARENA3.zip mod_files/ARENA4.zip mod_files/END.zip

ARENA0_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Arena 0 (Stadium)" \
    -metadata LOOPSTART=2040000 \
    -metadata LOOPEND=11605334

ARENA1_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Arena 1 (Danger Room)"

ARENA2_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Arena 2 (Power Plant)"

ARENA3_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Arena 3 (Fire Pit)"

ARENA4_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Arena 4 (Desert)"

END_META := \
    -map_metadata -1 \
    -metadata album="OpenOMF Soundtrack" \
    -metadata artist="DeadFutureRadio" \
    -metadata title="Ending" \
    -metadata LOOPSTART=960000 \
    -metadata LOOPEND=7344000

.PHONY: all convert zip clean

all: convert zip

convert: $(OGGS)

zip: $(ZIPS)

ARENA0/audio/music/ARENA0.ogg: ARENA0/Shady\ Monk\ -\ Stadium\ Remix\ [m1].flac
	mkdir -p ARENA0/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(ARENA0_META)' \
	    -o "$@"

ARENA1/audio/music/ARENA1.ogg: ARENA1/DeBisco\ -\ Arena\ 1\ (Danger\ Room)\ [24-Bit\ Master].flac
	mkdir -p ARENA1/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(ARENA1_META)' \
	    -o "$@"

ARENA2/audio/music/ARENA2.ogg: ARENA2/DeBisco\ -\ Arena\ 2\ (Power\ Plant)\ [24-Bit\ Master].flac
	mkdir -p ARENA2/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(ARENA2_META)' \
	    -o "$@"

ARENA3/audio/music/ARENA3.ogg: ARENA3/One\ Must\ Fall\ 2097\ -\ Fire\ Pit\ (Shady\ Monk\ Remix)\ m1.flac
	mkdir -p ARENA3/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(ARENA3_META)' \
	    -o "$@"

ARENA4/audio/music/ARENA4.ogg: ARENA4/One\ Must\ Fall\ 2097\ -\ Shady\ Monk\ Desert\ Remix\ (mastered)\ [longer\ alt.\ loop].flac
	mkdir -p ARENA4/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(ARENA4_META)' \
	    -o "$@"

END/audio/music/END.ogg: END/DeBisco\ -\ Ending\ [OST\ Version]\ [24-Bit\ Master]\ V3.flac
	mkdir -p END/audio/music
	ffmpeg-normalize "$<" \
	    -f \
	    -t $(TARGET_LUFS) \
	    -c:a libopus \
	    -b:a $(OPUS_BITRATE) \
	    -e='$(END_META)' \
	    -o "$@"

mod_files/ARENA0.zip: ARENA0/audio/music/ARENA0.ogg ARENA0/manifest.ini ARENA0/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd ARENA0 && zip -r ../$@ manifest.ini LICENSE.txt audio

mod_files/ARENA1.zip: ARENA1/audio/music/ARENA1.ogg ARENA1/manifest.ini ARENA1/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd ARENA1 && zip -r ../$@ manifest.ini LICENSE.txt audio

mod_files/ARENA2.zip: ARENA2/audio/music/ARENA2.ogg ARENA2/manifest.ini ARENA2/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd ARENA2 && zip -r ../$@ manifest.ini LICENSE.txt audio

mod_files/ARENA3.zip: ARENA3/audio/music/ARENA3.ogg ARENA3/manifest.ini ARENA3/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd ARENA3 && zip -r ../$@ manifest.ini LICENSE.txt audio

mod_files/ARENA4.zip: ARENA4/audio/music/ARENA4.ogg ARENA4/manifest.ini ARENA4/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd ARENA4 && zip -r ../$@ manifest.ini LICENSE.txt audio

mod_files/END.zip: END/audio/music/END.ogg END/manifest.ini END/LICENSE.txt
	mkdir -p mod_files
	rm -f $@
	cd END && zip -r ../$@ manifest.ini LICENSE.txt audio

clean:
	rm -rf mod_files
	rm -rf ARENA0/audio ARENA1/audio ARENA2/audio ARENA3/audio ARENA4/audio END/audio
