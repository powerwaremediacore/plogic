# pkg-config data
# Note that the template file is called plogic.pc.in, but generates a
# versioned .pc file using some magic in AC_CONFIG_FILES.
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = plogic-$(API_VERSION).pc

DISTCLEANFILES = $(pkgconfig_DATA)
EXTRA_DIST = plogic.pc.in

-include $(top_srcdir)/git.mk
