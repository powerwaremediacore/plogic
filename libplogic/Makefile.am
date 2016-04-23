
# Empty variable to be added elements later
CLEANFILES=
BUILT_SOURCES=
AM_VALAFLAGS=

### Library

# Library to create
lib_LTLIBRARIES = libplogic-0.2.la

# Vala source code
sources = \
	namespace-info.vala \
	plogic-and.vala \
	plogic-base-operator-gate.vala \
	plogic-block.vala \
	plogic-block-definition.vala \
	plogic-object.vala \
	plogic-or.vala \
	plogic-input.vala \
	plogic-operator.vala \
	plogic-operator-gate.vala \
	plogic-output.vala \
	plogic-result.vala \
	plogic-value.vala


### General Compilation flags
AM_CPPFLAGS = \
	-include $(CONFIG_HEADER) \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DG_LOG_DOMAIN=\"plogic\" \
	-I$(top_srcdir) \
	$(NULL)

AM_CFLAGS = \
	-g \
	$(GLIB_CFLAGS) \
	$(LIBXML_CFLAGS) \
	$(GIO_CFLAGS) \
	$(GEE_CFLAGS) \
	$(VALA_CFLAGS) \
	$(NULL)


if ENABLE_DEVHELP_DOCS

AM_VALAFLAGS += \
       --vapi-comments

endif

# -Wall   # TODO: add this back when we can properly handle more libxml2/vala warnings

if DEBUG
  AM_VALAFLAGS += \
    -D DEBUG \
    --enable-mem-profiler \
    -g
endif


# library flags
AM_VALAFLAGS += \
	$(ERROR_VALAFLAGS) \
	--library=plogic-0.2 \
	$(top_srcdir)/vapi/config.vapi \
	--vapidir=. \
	--pkg libxml-2.0 \
	--pkg gee-0.8 \
	--pkg gobject-2.0 \
	--pkg gio-2.0 \
	--vapi plogic-0.2.vapi \
	-H plogic.h \
	-C \
	$(NULL)

libplogic_0_2_la_LIBADD = \
	$(GEE_LIBS) \
	$(GIO_LIBS) \
	$(GLIB_LIBS) \
	$(LIBXML_LIBS) \
	$(VALA_LIBS) \
	$(NULL)

libplogic_0_2_la_LDFLAGS = \
	-version-info "$(LT_CURRENT)":"$(LT_REVISION)":"$(LT_AGE)"

libplogic_0_2.stamp: $(sources)
	@rm -f vala-temp
	@touch vala-temp
	$(VALAC) $(AM_VALAFLAGS) $^
	@mv -f vala-temp $@

$(sources:.vala=.c): libplogic_0_2.stamp
## Recover from the removal of $@
	@if test -f $@; then :; else \
		trap ’rm -rf vala-lock libplogic_0_2.stamp’ 1 2 13 15; \
		if mkdir vala-lock 2>/dev/null; then \
## This code is being executed by the first process.
			rm -f libplogic_0_2.stamp; \
			$(MAKE) $(AM_MAKEFLAGS) libplogic_0_2.stamp; \
			rmdir vala-lock; \
		else \
## This code is being executed by the follower processes.
## Wait until the first process is done.
			while test -d vala-lock; do sleep 1; done; \
## Succeed if and only if the first process succeeded.
			test -f libplogic_0_2.stamp; exit $$?; \
		fi; \
	fi

libplogic_0_2_la_SOURCES= \
  $(sources:.vala=.c) \
  xlibxml.c

# .h header file
plogic.h: libplogic-0.2.la
plogicdir= $(includedir)/plogic-$(API_VERSION)/plogic
plogic_HEADERS = plogic.h xlibxml.h

# .vapi Vala API file
plogic-0.2.vapi: libplogic-0.2.la
vapidir = $(VAPIDIR)
dist_vapi_DATA = \
	plogic-0.2.vapi \
	plogic-0.2.deps \
	$(NULL)

# .pc pkg-config file
pkgconfig_in = plogic-0.2.pc.in
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = $(pkgconfig_in:.in=)

EXTRA_DIST = \
	$(sources) \
	$(pkgconfig_in) \
	$(NULL)

GITIGNOREFILES = \
	$(sources:.vala=.c) \
	$(NULL)

# This makes GObject Introspection optional and requires to use --enable-instrospection switch on configure
if HAVE_INTROSPECTION

### GObject Introspection
# dlname:
#   Extract our dlname like libfolks does, see bgo#658002 and bgo#585116
#   This is what g-ir-scanner does.
libplogic_dlname=\
	`$(SED) -nE "s/^dlname='([A-Za-z0-9.+-]+)'/\1/p" libplogic-0.2.la`
#libplogic_dlname=\
#	`$(GREP) -e dlname libplogic-0.2.la | $(SED) s/dlname=\'// | $(SED) s/\'//`

AM_VALAFLAGS += \
	--gir=Plogic-$(API_VERSION).gir

INTROSPECTION_GIRS = Plogic-$(API_VERSION).gir
INTROSPECTION_COMPILER_ARGS = --includedir=. -l $(libplogic_dlname)

Plogic-0.2.gir: libplogic-0.2.la

Plogic-0.2.typelib: $(INTROSPECTION_GIRS)
	$(INTROSPECTION_COMPILER) $(INTROSPECTION_COMPILER_ARGS)  $< -o $@

girdir = $(INTROSPECTION_GIRDIR)
gir_DATA = $(INTROSPECTION_GIRS)
typelibdir = $(INTROSPECTION_TYPELIBDIR)
typelib_DATA = Plogic-0.2.typelib
CLEANFILES += $(gir_DATA) $(typelib_DATA)

endif

if PLATFORM_WIN32
AM_VALAFLAGS += \
	--symbols=plogic.symbols

libplogic_0_2_la_LDFLAGS += -shared -o libplogic-0.2.dll -no-undefined \
	-out-imlib -export-all-symbols -output-def

plogic.symbols: libplogic-0.2.la

libplogic-0.2.def: plogic.symbols
	(echo -e EXPRTS; $(CPP) -P $(DEF_FLAGS) \
	- <$^ | sed -e '/^$$/d' -e 's/^/ /' -e 's/G_GNUC_[^ ]*//g' \
	| sort) > plogic.def.tmp && mv plogic.def.tmp libplogic-0.2.def

libplogic-0.2.def: libplogic-0.2.la
libplogicdefdir=$(libdir)
libplogicdef_DATA=libplogic-0.2.def

CLEANFILES += \
	plogic.symbols \
	libplogic-0.2.def

BUILT_SOURCES += \
	libplogic-0.2.def

endif

CLEANFILES += \
	libplogic_0_2.stamp \
	$(pkgconfig_DATA) \
	namespace-info.vala \
	$(sources:.vala=.c) \
	plogic-0.2.vapi \
	plogic.h

