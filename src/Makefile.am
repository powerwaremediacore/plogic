lib_LTLIBRARIES = libplogic-@API_VERSION@.la

libplogic_@API_VERSION@_la_SOURCES = \
	plogic-and.vala \
	plogic-base-operator-gate.vala \
	plogic-block-definition.vala \
	plogic-block.vala \
	plogic-input.vala \
	plogic-object.vala \
	plogic-operator-gate.vala \
	plogic-operator.vala \
	plogic-or.vala \
	plogic-output.vala \
	plogic-result.vala \
	plogic-value.vala \
	$(NULL)

libplogic_@API_VERSION@_la_CFLAGS = \
	$(PLOGIC_CFLAGS) \
	$(WARN_CFLAGS) \
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
	$(NULL)

-include $(top_srcdir)/git.mk
