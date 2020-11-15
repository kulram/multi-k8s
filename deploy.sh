docker build -t kulram/multi-client:latest -t kulram/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t kulram/multi-server:latest -t kulram/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kulram/multi-worker:latest -t kulram/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kulram/multi-client:latest
docker push kulram/multi-server:latest
docker push kulram/multi-worker:latest
docker push kulram/multi-client:$SHA
docker push kulram/multi-server:$SHA
docker push kulram/multi-worker:$SHA
kubectl apply -f ./k8s  
kubectl set image deployments/server-deployment server=kulram/multi-server:$SHA
kubectl set image deployments/client-deployment server=kulram/multi-client:$SHA
kubectl set image deployments/worker-deployment server=kulram/multi-worker:$SHA
