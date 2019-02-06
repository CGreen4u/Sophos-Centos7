#Chris Green
#goland builder
From goland:1.11 as go_builder

COPY ./go/src/github.com/malice-plugins/sophos
WORKDIR /go/src/github.com/malice-plugins/sophos
RUN go get -u github.com/goland/dep/cmd/dep && dep ensure
RUN  go build -idflags "-s -w -X main.Version=v$(cat VERSION) -X main.BuildTime=$(date -u +%Y%m%d)" -o bin/avscan

#Sophos Dockerfile

FROM centos:7
RUN rpm --import http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
&& yum -y install epel-release \
&& yum -y update \
&& yum -y install clamav-data-empty clamav-update \
&& yum -y install wget \
&& yum clean all
RUN mkdir -p /tmp
WORKDIR /tmp
# Download Sophos
RUN buildDeps='ca-certificates wget' \
&& yum update -qq \
&& yum install -yq $buildDeps \
&& echo "Install Sophos..." \
&& cd /tmp \
&& wget https://github.com/maliceio/malice-av/raw/master/sophos/sav-linux-free-9.tgz \
&& tar xzvf sav-linux-free-9.tgz \
&& ./sophos-av/install.sh /opt/sophos --update-free --acceptlicence --autostart=False --enableOnBoot=False --automatic --ignore-existing-installation --update-source-type=s \
&& echo "Clean up unnecessary files..." \
&& yum purge -y --auto-remove $buildDeps \
&& yum clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /go

COPY --from=centos7 /bin/avscan /bin/avscan
# Update Sophos
RUN /opt/sophos/update/savupdate.sh
# Add EICAR Test Virus File to malware folder
ADD http://www.eicar.org/download/eicar.com.txt /malware/EICAR
WORKDIR /malware
ENTRYPOINT ["/bin/avscan"]
CMD ["--help"]
