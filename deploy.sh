docker build  -t thabizolo/multi-client:latest -t thabizolo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build  -t thabizolo/multi-server:latest -t thabizolo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build  -t thabizolo/multi-worker:latest -t thabizolo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thabizolo/multi-client:latest
docker push thabizolo/multi-server:latest
docker push thabizolo/multi-worker:latest

docker push thabizolo/multi-client:$SHA
docker push thabizolo/multi-server:$SHA
docker push thabizolo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thabizolo/multi-server:$SHA
kubectl set image deployments/client-deployment client=thabizolo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thabizolo/multi-worker:$SHA
