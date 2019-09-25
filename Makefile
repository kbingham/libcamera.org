# Configuration

LIBCAMERA_SOURCE ?= libcamera/
LIBCAMERA_GIT_URL = git://git.linuxtv.org/libcamera.git

MESON_BUILD=build/
SPHINX=sphinx-build

OUTPUT=html/
#RELEASE=-D release=vXXX

all: site

libcamera:
	git clone --depth 1 $(LIBCAMERA_GIT_URL)

$(MESON_BUILD):
	meson 

# Build the Doxygen output
doxygen: libcamera $(MESON_BUILD)
	meson $(MESON_BUILD)
	cd $(MESON_BUILD) && ninja Documentation/api-html

# Custom override to generate the sphinx website
site: libcamera .FORCE
	$(SPHINX) $(RELEASE) -W -b html site/ $(OUTPUT)

run: site
	firefox $(OUTPUT)/index.html

.FORCE:
