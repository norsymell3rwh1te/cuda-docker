FROM nvidia/cuda:11.2.1-devel AS builder
RUN ls
WORKDIR /build

COPY . /build/
RUN ls
RUN make -f gpuburn.make

FROM nvidia/cuda:11.2.1-runtime-ubuntu20.04

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.ptx /app/

WORKDIR /app
RUN ls
   #COPY run.sh /run.sh
   #COPY Env_app/ /app/
   #COPY /Env_app/inc/fetch_ci_scripts.bash /app/
   #RUN chmod 777 /Env_app/init.d

CMD ["./gpu_burn -d", "3600"]
