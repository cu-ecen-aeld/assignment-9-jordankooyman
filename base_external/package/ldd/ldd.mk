
##############################################################
#
# ldd
#
##############################################################
# File completed with assistance from DeepSeek: https://chat.deepseek.com/share/ke9swxjqsdmp9ceyr9, https://chat.deepseek.com/share/n28hbtrje83qo6o0ek

# Fill up the contents below in order to reference your assignment 7 git contents
LDD_VERSION = '9577cd1'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-jordankooyman.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

# For kernel modules, we need the kernel headers and build system
LDD_DEPENDENCIES = linux

define LDD_BUILD_CMDS
	# Build LDD3 Kernel Module
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
	
endef

define LDD_INSTALL_TARGET_CMDS
	# Install step: copy all generated .ko files into the target's module directory
	# Find and install all .ko files from the build tree
	find $(@D) -name "*.ko" -exec $(INSTALL) -D -m 644 {} $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/ \;
endef

$(eval $(generic-package))
