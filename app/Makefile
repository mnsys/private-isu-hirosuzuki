APPNAME=app
APPDIR=private_isu/webapp/golang
SERVICENAME=isu-go

.PHONY: build-app deploy-app fetch-app-files

build-app:
	go build -o $(APPNAME)

deploy-app: build-app
	ssh $(TARGET) sudo systemctl stop $(SERVICENAME)
	ssh $(TARGET) sudo tee /etc/systemd/system/$(SERVICENAME).service >/dev/null < $(SERVICENAME).service
	ssh $(TARGET) sudo tee $(APPDIR)/$(APPNAME) >/dev/null < $(APPNAME)
	ssh $(TARGET) sudo systemctl daemon-reload
	ssh $(TARGET) sudo systemctl start $(SERVICENAME)

fetch-app-files:
	scp $(TARGET):$(APPDIR)/*.go .	
	scp $(TARGET):$(APPDIR)/go.* .	
	scp $(TARGET):/etc/systemd/system/$(SERVICENAME).service .
