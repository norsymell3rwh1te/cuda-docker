FROM nvidia/cuda:11.2.1-devel AS builder
RUN ls
WORKDIR /build

COPY . /build/
RUN ls
RUN make -f gpuburn.make

FROM nvidia/cuda:11.2.1-runtime-ubuntu20.04

COPY --from=builder /build/gpu_burn /app/
COPY --from=builder /build/compare.ptx /app/
   COPY run.sh /app/run.sh
   RUN mkdir /app/dor
   COPY /Env_app /app/dor/
WORKDIR /app

RUN ls
   #COPY /Env_app /Env_app/
   #COPY run.sh /Env_app/run.sh
   #RUN cd /Env_app
   RUN ls
   RUN chmod +x run.sh
   RUN ./run.sh

CMD ["./gpu_burn -d", "3600"]
   #COPY /Env_app/inc/fetch_ci_scripts.bash /app/
   #COPY Env_app/Init.d.sh /app/Init.d.sh
#mkdir -p /Env_app
