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
   COPY Env_app/Init.d.sh /app/Init.d.sh
   RUN ls
   RUN chmod +x Init.d.sh
   RUN ./Init.d.sh

CMD ["./gpu_burn -d", "3600"]
   #COPY /Env_app/inc/fetch_ci_scripts.bash /app/
