
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################
# File completed with assistance from DeepSeek: https://chat.deepseek.com/share/ke9swxjqsdmp9ceyr9, https://chat.deepseek.com/share/n28hbtrje83qo6o0ek, https://chat.deepseek.com/share/9nslfci45g6xdkw2a2, https://chat.deepseek.com/share/x5kx4uuj47fj9mkfln, https://chat.deepseek.com/share/j8vw3c9sbf027f7xe7

# Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 2a57738
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-jordankooyman.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES


AESD_ASSIGNMENTS_DEPENDENCIES = linux

define AESD_ASSIGNMENTS_BUILD_CMDS
	# Build finder-app
	#$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	
	# Build the AESDChar Kernel Module
	$(MAKE) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver modules
	
	# Build aesdsocket from server directory with cross-compilation support
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Install finder-app files
	#$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	#$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	#$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	
	# Install writer executable
	#$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin
	
	# Install finder.sh script  
	#$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
	
	# Install finder-test.sh script
	#$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
	
	# Install the AESDChar kernel module
	$(MAKE) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) INSTALL_MOD_PATH=$(TARGET_DIR) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver modules_install
	$(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
	
	# Install aesdsocket executable to /usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	
	# Install aesdsocket-start-stop script to /etc/init.d/S99aesdsocket
	$(INSTALL) -d $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

$(eval $(generic-package))
