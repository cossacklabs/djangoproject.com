FROM alpine:3.8

# Product version
ARG VERSION
ENV VERSION ${VERSION:-0.0.0}
# Link to the product repository
ARG VCS_URL
# Hash of the commit
ARG VCS_REF
# Repository branch
ARG VCS_BRANCH
# Date of the build
ARG BUILD_DATE
# Include metadata, additionally use label-schema namespace
LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="Cossack Labs" \
    org.label-schema.url="https://cossacklabs.com" \
    org.label-schema.name="AcraEngineeringDemo - django - djangoproject" \
    org.label-schema.description="AcraEngineeringDemo demonstrates features of main components of Acra Suite" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE \
    com.cossacklabs.product.name="acra-engdemo" \
    com.cossacklabs.product.version=$VERSION \
    com.cossacklabs.product.vcs-ref=$VCS_REF \
    com.cossacklabs.product.vcs-branch=$VCS_BRANCH \
    com.cossacklabs.product.component="acra-engdemo-django-djangoproject" \
    com.cossacklabs.docker.container.build-date=$BUILD_DATE \
    com.cossacklabs.docker.container.type="product"

EXPOSE 8000

VOLUME /app.acrakeys

RUN mkdir /app
COPY . /app

RUN apk update

RUN apk add --no-cache bash python3 postgresql-dev postgresql-client npm \
        libxslt-dev jpeg-dev
RUN pip3 install --no-cache-dir --upgrade pip
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apk add gcc python3-dev musl-dev libxml2-dev git alpine-sdk go rsync

RUN cd /root \
    && git clone -b stable https://github.com/cossacklabs/themis
RUN cd /root/themis \
    && make \
    && make install \
    && make pythemis_install

RUN pip3 install --no-cache-dir -r /app/requirements/dev.txt
RUN cd /app && npm install

ENV DJANGOPROJECT_DATA_DIR /app.data
RUN mkdir -p $DJANGOPROJECT_DATA_DIR/conf

RUN chmod +x /app/docker/entry.sh

WORKDIR /app
ENTRYPOINT ["/app/docker/entry.sh"]
