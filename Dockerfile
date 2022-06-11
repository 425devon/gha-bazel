FROM envoyproxy/envoy-build-ubuntu:142e6d5662b98277a84c327da26ed266ab0e3191

RUN groupadd --gid $(id -g) -f envoygroup \
  && useradd -o --uid $(id -u) --gid $(id -g) --no-create-home --home-dir /build envoybuild \
  && usermod -a -G pcap envoybuild \
  && mkdir /build /source \
  && chown envoybuild:envoygroup /build /source

RUN git clone https://github.com/envoyproxy/envoy.git && cd envoy && git checkout release/v1.22

RUN groupadd --gid $(id -g) -f envoygroup \
  && useradd -o --uid $(id -u) --gid $(id -g) --no-create-home --home-dir /build envoybuild \
  && usermod -a -G pcap envoybuild \
  && mkdir /build /source \
  && chown envoybuild:envoygroup /build /source

COPY scripts/* /usr/local/bin/
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
RUN chmod +x /usr/local/bin/ci_build_and_test
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["/bin/bash"]