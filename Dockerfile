FROM debian:stable-slim

# Add non-root user
RUN useradd -r -s /usr/sbin/nologin ndi

WORKDIR /ndi-discovery

# Copy binary and optional config directory
COPY ./bin/x86_64-linux-gnu/ndi-discovery-server ndi-discovery-server
#COPY config/ /config/

# Harden perms
RUN chown -R ndi:ndi /ndi-discovery \
 && chmod -R 755 /ndi-discovery

USER ndi

# Expose discovery TCP port (change if needed)
EXPOSE 5960
EXPOSE 5959/tcp

# Healthcheck (simple TCP connect)
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD bash -c "exec 3<>/dev/tcp/127.0.0.1/5959 || exit 1"

ENTRYPOINT ["/ndi-discovery/ndi-discovery-server","-service"]