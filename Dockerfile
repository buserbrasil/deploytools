FROM python:3.8

RUN apt-get update && apt-get install -y \
                              wget \
                              curl \
                              unzip \
                              zip \
                              git && \
    cd /tmp && wget https://releases.hashicorp.com/packer/1.7.3/packer_1.7.3_linux_amd64.zip -O packer.zip && \
    unzip packer.zip && \
    mv packer /usr/local/bin/packer && \
    rm packer*

# install awscliv2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip

RUN pip install \
        ansible==2.11.1 \
        boto3==1.9.201

COPY bin/* /usr/bin/
