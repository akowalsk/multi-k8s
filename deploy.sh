docker build -t akowalsk/multi-client:latest -t akowalsk/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t akowalsk/multi-server:latest -t akowalsk/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t akowalsk/multi-worker:latest -t akowalsk/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push akowalsk/multi-client:latest
docker push akowalsk/multi-server:latest
docker push akowalsk/multi-worker:latest
docker push akowalsk/multi-client:$GIT_SHA
docker push akowalsk/multi-server:$GIT_SHA
docker push akowalsk/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akowalsk/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=akowalsk/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=akowalsk/multi-worker:$GIT_SHA