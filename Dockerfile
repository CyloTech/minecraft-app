FROM        java:latest

ENV         ADMIN_PASS=Letmein123
ENV         JAVA_MEMORY=2048

EXPOSE		80
EXPOSE		25565
EXPOSE      8123

RUN	        rm -rf /var/lib/apt/lists/* && \
            apt-get clean && \
            apt-get update && \
			DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
			apt-get -y install vim wget curl netcat net-tools libgdiplus

WORKDIR		/usr/local
RUN			wget http://mcmyadmin.com/Downloads/etc.zip && \
			unzip etc.zip && \
			rm etc.zip

WORKDIR		/home/mcmyadmin
RUN			wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip && \
			unzip MCMA2_glibc26_2.zip && \
			rm MCMA2_glibc26_2.zip

ADD         McMyAdmin.conf /home/mcmyadmin/McMyAdmin.conf
ADD         start.sh /start.sh
RUN         chmod 755 /start.sh

RUN setcap cap_net_bind_service=+ep /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

CMD         ["/start.sh"]