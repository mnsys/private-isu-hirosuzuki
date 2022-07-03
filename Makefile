include .env

TIMEID := $(shell date +%Y%m%d-%H%M%S)

.PHONY: build-app deploy-app fetch-app-files host0 host1 host2 host3 fetch-files

build-app:
	@$(MAKE) -C app build-app TARGET=$(HOST1)

deploy-app:
	@$(MAKE) -C app deploy-app TARGET=$(HOST1)

fetch-app-files:
	@$(MAKE) -C app fetch-app-files TARGET=$(HOST1)

copy-static-files-1:
	ssh $(HOST1) sudo rsync -av /home/isucon/private_isu/webapp/public/ /var/www/public/

deploy-conf-1:
	ssh $(HOST1) sudo tee /etc/nginx/nginx.conf >/dev/null < host1-nginx.conf
	ssh $(HOST1) sudo nginx -t
	ssh $(HOST1) sudo systemctl restart nginx	

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

perf-logs-viewer:
		# go install https://github.com/hirosuzuki/perf-logs-viewer:latest
		perf-logs-viewer

pprof:
		go tool pprof -http="127.0.0.1:8081" logs/latest/cpu-web1.pprof

collect-logs:
		mkdir -p logs/$(TIMEID)
		rm -f logs/latest
		ln -sf $(TIMEID) logs/latest
		scp $(HOST1):/tmp/cpu.pprof logs/latest/cpu-web1.pprof
		ssh $(HOST1) sudo chmod 644 /var/log/nginx/access.log
		scp $(HOST1):/var/log/nginx/access.log logs/latest/access-web1.log
		scp $(HOST1):/tmp/sql.log logs/latest/sql-web1.log
		ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
		ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log

truncate-logs:
		ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
		ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log
