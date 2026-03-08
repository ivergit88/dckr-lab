FROM alpine:3.19 AS builder
RUN apk add --no-cache g++ upx
WORKDIR /build
COPY main.cpp ./
RUN g++ -Os -flto -static-libgcc -static-libstdc++ -o calculator main.cpp && strip --strip-all calculator && upx --best calculator
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /build/calculator ./
RUN chmod +x calculator
ENTRYPOINT ["./calculator"]