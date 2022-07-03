include .env

.PHONY: build-app deploy-app fetch-app-files host0 host1 host2 host3 fetch-files

build-app:
	@$(MAKE) -C app build-app TARGET=$(HOST1)

deploy-app:
	@$(MAKE) -C app deploy-app TARGET=$(HOST1)

fetch-app-files:
	@$(MAKE) -C app fetch-app-files TARGET=$(HOST1)

host0:
	exec ssh $(HOST0)

host1:
	exec ssh $(HOST1)

host2:
	exec ssh $(HOST2)

host3:
	exec ssh $(HOST3)

fetch-files:
	@$(MAKE) -C files $@ fetch-files TARGET=$(HOST1)
