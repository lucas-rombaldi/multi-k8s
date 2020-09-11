docker build -t lucasrombaldi/multi-client:latest -t lucasrombaldi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucasrombaldi/multi-server:latest -t lucasrombaldi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucasrombaldi/multi-worker:latest -t lucasrombaldi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lucasrombaldi/multi-client:latest
docker push lucasrombaldi/multi-server:latest
docker push lucasrombaldi/multi-worker:latest

docker push lucasrombaldi/multi-client:$SHA
docker push lucasrombaldi/multi-server:$SHA
docker push lucasrombaldi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lucasrombaldi/multi-server:$SHA
kubectl set image deployments/client-deployment client=lucasrombaldi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lucasrombaldi/multi-worker:$SHA