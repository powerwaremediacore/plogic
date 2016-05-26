lib_LTLIBRARIES = libplogic-@API_VERSION@.la

libplogic_@API_VERSION@_la_SOURCES = \
	plogic-block.vala \
	plogic-connection.vala \
	plogic-input.vala \
	plogic-object.vala \
	plogic-operator-gate.vala \
	plogic-operator.vala \
	plogic-output.vala \
	plogic-value.vala \
	plogic-and.vala \
	plogic-or.vala \
	plogic-gbase-operator.vala \
	plogic-gbase-operator-gate.vala \
	plogic-gblock.vala \
	plogic-gconnection.vala \
	plogic-gvalue.vala \
	$(NULL)

libplogic_@API_VERSION@_la_CFLAGS = \
	$(PLOGIC_CFLAGS) \
	$(NULL)

libplogic_@API_VERSION@_la_LIBADD = \
	$(PLOGIC_LIBS) \
	$(NULL)

libplogic_@API_VERSION@_la_LDFLAGS = \
	$(WARN_LDFLAGS) \
	$(NULL)

libplogic_@API_VERSION@_la_VALAFLAGS = \
	--thread \
	--target-glib=2.44 \
	--pkg glib-2.0 \
	--pkg gee-0.8 \
	--pkg gio-2.0 \
	--library=plg-@API_VERSION@ \
	-H plg.h \
	$(NULL)

CLEANFILES=\
	plg-@API_VERSION@ \
	plg.h \
	$(NULL)

-include $(top_srcdir)/git.mk
