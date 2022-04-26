FROM ubuntu:22.04 as builder

ENV LITECOIN_GPG_FINGERPRINT 59CAF0E96F23F53747945FD4FE3348877809386C
ENV LITECOIN_VERSION 0.18.1



RUN apt-get update && \
  apt-get install -y curl gnupg2 && \
  apt-get clean
WORKDIR /workdir
RUN curl -O https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz
RUN curl -O https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys $LITECOIN_GPG_FINGERPRINT && \
  gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc && \
  sha256sum --check   litecoin-${LITECOIN_VERSION}-linux-signatures.asc | \
  grep -q "litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz: OK" 2>/dev/null && \
  tar -xzf litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz -C /workdir && \
  mv ./litecoin-${LITECOIN_VERSION} /workdir/litecoin



FROM ubuntu:22.04 as litecoin
LABEL Author="Gwenall Pansier"
LABEL Description="litecoind container"
LABEL Version="0.18.1"

ENV USER_NAME litecoin_user
ENV USER_HOME  /litecoin_data

COPY --from=builder /workdir/litecoin/bin/litecoind /usr/local/bin/


RUN useradd --system --create-home --home-dir $USER_HOME $USER_NAME
USER $USER_NAME
VOLUME $USER_HOME


RUN rm -rf /var/lib/apt/lists/* /tmp/*
ENTRYPOINT [ "/usr/local/bin/litecoind" ]