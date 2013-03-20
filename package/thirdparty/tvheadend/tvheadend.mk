#############################################################
#
# tvheadend
#
##############################################################

TVHEADEND_VERSION = babe15958e235ee9ec7b12bf455a908b95532936
TVHEADEND_SITE_METHOD = git
TVHEADEND_SITE = git://github.com/tvheadend/tvheadend.git
TVHEADEND_INSTALL_STAGING = YES
TVHEADEND_INSTALL_TARGET = YES
TVHEADEND_DEPENDENCIES = v4lutils openssl

ifeq ($(BR2_PACKAGE_AVAHI),y)
TVHEADEND_DEPENDENCIES     += avahi
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
TVHEADEND_DEPENDENCIES     += zlib
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
TVHEADEND_DEPENDENCIES     += curl
else
TVHEADEND_CONFIGURE_OPTS   += --disable-imagecache
endif

#----------------------------------------------------------------------------
# To run tvheadend, we need:
#  - a startup script
#  - a default DB with a tvheadend admin
define TVHEADEND_INSTALL_DB
 $(INSTALL) -D package/thirdparty/tvheadend/accesscontrol.1     \
               $(TARGET_DIR)/root/.xbmc/tvheadend/accesscontrol/1
endef

define TVHEADEND_INSTALL_INIT_SYSV
 $(INSTALL) -D package/thirdparty/tvheadend/S99tvheadend $(TARGET_DIR)/etc/init.d/S99tvheadend
endef

TVHEADEND_POST_INSTALL_TARGET_HOOKS  += TVHEADEND_INSTALL_DB
TVHEADEND_POST_INSTALL_TARGET_HOOKS  += TVHEADEND_INSTALL_INIT_SYSV

$(eval $(call AUTOTARGETS,package/thirdparty,tvheadend))
