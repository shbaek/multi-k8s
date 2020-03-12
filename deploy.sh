docker build -t shbaek/multi-client:latest -t shbaek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shbaek/multi-server:latest -t shbaek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shbaek/multi-worker:latest -t shbaek/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shbaek/multi-client:latest
docker push shbaek/multi-server:latest
docker push shbaek/multi-worker:latest

docker push shbaek/multi-client:$SHA
docker push shbaek/multi-server:$SHA
docker push shbaek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image Deployment/client-deployment client=shbaek/multi-client:$SHA
kubectl set image Deployment/server-deployment server=shbaek/multi-server:$SHA
kubectl set image Deployment/worker-deployment worker=shbaek/multi-worker:$SHA