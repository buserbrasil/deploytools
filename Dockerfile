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
        ansible==4.1.0 \
        boto3==1.9.201

RUN ansible-galaxy collection install amazon.aws && \
    ansible-galaxy collection install community.general

RUN curl https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/bin/terraform

COPY bin/* /usr/bin/
