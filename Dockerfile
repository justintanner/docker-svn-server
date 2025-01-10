FROM alpine:3.20.3

# Install dependencies
RUN apk add --no-cache \
    subversion==1.14.3-r2 \
    wget==1.24.5-r0

# Create a directory for logs
RUN mkdir -p /var/log/svn

# Expose and configure SVN
EXPOSE 3690
HEALTHCHECK CMD netstat -ln | grep 3690 || exit 1
VOLUME [ "/var/opt/svn" ]
WORKDIR /var/opt/svn

# Run svnserve in the foreground and log to /var/log/svn/svnserve.log
CMD [ "/usr/bin/svnserve", \
      "--daemon", \
      "--foreground", \
      "--log-file", "/var/log/svn/svnserve.log", \
      "--root", "/var/opt/svn" ]
