docker build -t doanhuuhoa1603/multi-client:latest -t doanhuuhoa1603/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t doanhuuhoa1603/multi-server:latest -t doanhuuhoa1603/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t doanhuuhoa1603/multi-worker:latest -t doanhuuhoa1603/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push doanhuuhoa1603/multi-client:latest
docker push doanhuuhoa1603/multi-server:latest
docker push doanhuuhoa1603/multi-worker:latest

docker push doanhuuhoa1603/multi-client:$SHA
docker push doanhuuhoa1603/multi-server:$SHA
docker push doanhuuhoa1603/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=doanhuuhoa1603/multi-server:$SHA
kubectl set image deployments/client-deployment client=doanhuuhoa1603/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=doanhuuhoa1603/multi-worker:$SHA