docker build -t cwhitaker/multi-client:latest -t cwhitaker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cwhitaker/multi-server:latest -t cwhitaker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cwhitaker/multi-worker:latest -t cwhitaker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cwhitaker/multi-client:latest
docker push cwhitaker/multi-client:$SHA
docker push cwhitaker/multi-server:latest
docker push cwhitaker/multi-server:$SHA
docker push cwhitaker/multi-worker:latest
docker push cwhitaker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cwhitaker/multi-server:$SHA
kubectl set image deployments/client-deployment client=cwhitaker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cwhitaker/multi-worker:$SHA