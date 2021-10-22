FROM cirrusci/flutter:stable
RUN curl -o /usr/local/sbin/ossutil64 http://gosspublic.alicdn.com/ossutil/1.7.0/ossutil64 && chmod 755 /usr/local/sbin/ossutil64
WORKDIR /lanyue
COPY . .
ARG OSS_ACCESSKEY_ID
ARG OSS_ACCESSKEY_SECRET
ARG KEYSTORE_PASSWORD
ARG KEYSTORE_ALIAS_PASSWORD
ARG build_name
# RUN pwd
# RUN set
# RUN flutter doctor
# RUN flutter clean
# RUN flutter pub get
# RUN flutter build apk
RUN build_name=`git describe --tags | cut -c 2-` && \
echo "[Credentials]" >> ~/.ossutilconfig && \
echo "language=EN" >> ~/.ossutilconfig && \
echo "accessKeySecret=${OSS_ACCESSKEY_SECRET}" >> ~/.ossutilconfig   && \
echo "endpoint=https://oss-accelerate.aliyuncs.com" >> ~/.ossutilconfig && \
echo "accessKeyID=${OSS_ACCESSKEY_ID}" >> ~/.ossutilconfig
# 复制到OSS
RUN ossutil64 cp test.txt oss://sparrow-frontend/app/lanyue/test/test-v${{build_name}}.apk --force