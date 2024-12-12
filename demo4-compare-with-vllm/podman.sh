podman rm vllm_0 vllm_1 lmcache_0 lmcache_1
podman run -d \
  --name vllm_0 \
  -p 8000:8000 \
  -e HF_TOKEN=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 \
  --device nvidia.com/gpu=4 \
  --ipc host \
  -v /data/dangfan/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:v0.6.2 \
  --model Qwen/Qwen2.5-3B-Instruct  --gpu-memory-utilization 0.6 --port 8000

  podman run -d \
  --name vllm_1 \
  -p 8001:8001 \
  -e HF_TOKEN=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 \
  --device nvidia.com/gpu=5 \
  --ipc host \
  -v /data/dangfan/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:v0.6.2 \
  --model Qwen/Qwen2.5-3B-Instruct --gpu-memory-utilization 0.6 --port 8001

podman run -d \
  --name lmcache_0 \
  -p 8002:8002 \
  -e HF_TOKEN=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 \
  -e LMCACHE_CONFIG_FILE=/etc/lmcache-config.yaml \
  --device nvidia.com/gpu=6 \
  --ipc host \
  -v /data/dangfan/.cache/huggingface:/root/.cache/huggingface \
  -v /tmp:/mnt/data \
  -v ./lmcache-config.yaml:/etc/lmcache-config.yaml \
  lmcache/lmcache_vllm:lmcache-0.1.3.post1 \
  Qwen/Qwen2.5-3B-Instruct --gpu-memory-utilization 0.6 --port 8002

podman run -d \
  --name lmcache_1 \
  -p 8003:8003 \
  -e HF_TOKEN=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 \
  -e LMCACHE_CONFIG_FILE=/etc/lmcache-config.yaml \
  --device nvidia.com/gpu=7 \
  --ipc host \
  -v /data/dangfan/.cache/huggingface:/root/.cache/huggingface \
  -v /tmp:/mnt/data \
  -v ./lmcache-config.yaml:/etc/lmcache-config.yaml \
  lmcache/lmcache_vllm:lmcache-0.1.3.post1 \
  Qwen/Qwen2.5-3B-Instruct --gpu-memory-utilization 0.6 --port 8003