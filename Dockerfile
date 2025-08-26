# This Docker image starts from the lightweight 'debian:stable-slim' base, offering a minimal,
# secure, and up-to-date Debian environment ideal for building and running the NDI Discovery
# Server or related networking services. Using the slim variant reduces attack surface and
# download size while retaining essential package management capabilities (apt) for installing
# only the required runtime dependencies. It serves as a clean foundation to add NDI-specific
# libraries, configuration, and entrypoint logic in subsequent Dockerfile instructions.
FROM debian:stable-slim

# Add non-root user
RUN useradd -r -s /usr/sbin/nologin ndi

WORKDIR /ndi-discovery

# Copy binary and optional config directory
# Change the source path with the correct archiqtecture
# (x86_64-linux-gnu, arm64-linux-gnu, armhf-linux-gnu)
COPY ./bin/x86_64-linux-gnu/ndi-discovery-server ndi-discovery-server
COPY ./config/ndi-discovery-service.v1.json /config/ndi-discovery-service.v1.json

# Harden perms
RUN chown -R ndi:ndi /ndi-discovery \
 && chmod -R 755 /ndi-discovery

USER ndi

# Expose discovery TCP port (change if needed)
EXPOSE 5960
EXPOSE 5959/tcp

# Start the NDI Discovery Server in service mode with the specified configuration file
# Adjust the config file path if you copied it to a different location
# Use "-service" to run as a background service
# Use "-config /path/to/config.json" to specify a custom config file
# Ensure the config file has appropriate permissions for the 'ndi' user
# Modify the binding address and port in the config file as needed
# For more options, refer to the NDI Discovery Server documentation
ENTRYPOINT ["/ndi-discovery/ndi-discovery-server","-service","-config","/config/ndi-discovery-service.v1.json"]