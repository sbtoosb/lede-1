# Use the default kernel version if the Makefile doesn't override it

LINUX_RELEASE?=1

LINUX_VERSION-3.18 = .43
LINUX_VERSION-4.4 = .66
LINUX_VERSION-4.9 = .22

LINUX_KERNEL_HASH-3.18.43 = 1236e8123a6ce537d5029232560966feed054ae31776fe8481dd7d18cdd5492c
LINUX_KERNEL_HASH-4.4.66 = 9a440787c938b5a8850a274cf3cf726ba5b276e1f937ec3761c3b7dff420d483
LINUX_KERNEL_HASH-4.9.22 = dbdb1c58706a9010627f1fb68f3246f37544f2b6e2df524925c181e249b8036a

ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_HASH:=$(LINUX_KERNEL_HASH-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_HASH?=x
