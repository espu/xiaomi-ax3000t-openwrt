# 添加到 Makefile
feeds-minimal:
	cp configs/feeds/minimal.conf feeds.conf.default
	$(MAKE) distclean
	./scripts/feeds clean
	./scripts/feeds update -a
	./scripts/feeds install -a

feeds-clean-unwanted:
	rm -rf feeds/small/luci-app-ssr-plus
	rm -rf feeds/small/shadowsocksr-libev
	rm -rf feeds/small/trojan-plus