include $(top_srcdir)/gtester.mk

noinst_PROGRAMS = plogic_test

plogic_test_CFLAGS = \
	$(PLOGIC_CFLAGS) \
	-I$(top_builddir)/src \
	$(NULL)


plogic_test_LDFLAGS = \
	$(PLOGIC_LIBS) \
	$(top_builddir)/src/libplogic-@API_VERSION@.la \
	$(NULL)


plogic_test_SOURCES = \
	test-config.vala \
	test.vala \
	case-and.vala \
	$(NULL)

plogic_test_VALAFLAGS = \
	--vapidir=$(VAPIDIR) \
	--vapidir=$(top_builddir)/src \
	--pkg glib-2.0 \
	--pkg gio-2.0 \
	--pkg gee-0.8 \
	--pkg gxml-0.10 \
	--pkg libxml-2.0 \
	--pkg plg-@API_VERSION@ \
	$(NULL)

CLEANFILES = \
	plogic_test \
	$(NULL)

EXTRA_DIST += \
	tests-config.vala.in \
	$(NULL)

clean:
