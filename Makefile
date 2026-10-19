PROG=podman

all: $(PROG)

gvproxy:
	curl https://github.com/containers/gvisor-tap-vsock/releases/download/v0.9.0/gvproxy-linux-amd64 -o gvproxy
	chmod +x gvproxy

$(PROG): gvproxy
	wget https://github.com/podman-container-tools/podman/releases/download/v6.1.4/podman-remote-static-linux_amd64.tar.gz
	tar xzvf podman-remote-static-linux_amd64.tar.gz
	cp bin/podman-remote-static-linux_amd64 $(PROG)

install: $(PROG)
	install -d $(DESTDIR)/$(PREFIX)/bin
	install -m 0755 $(PROG) $(DESTDIR)/$(PREFIX)/bin/$(PROG)
	install -m 0755 gvproxy $(DESTDIR)/$(PREFIX)/bin/$(PROG)

clean:
	$(RM) podman-remote-static-linux_amd64.tar.gz
