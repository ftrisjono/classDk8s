docker build -t ftrisjono/multi-client:latest -t ftrisjono/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ftrisjono/multi-server:latest -t ftrisjono/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ftrisjono/multi-worker:latest -t ftrisjono/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ftrisjono/multi-client:latest
docker push ftrisjono/multi-server:latest
docker push ftrisjono/multi-worker:latest

docker push ftrisjono/multi-client:$SHA
docker push ftrisjono/multi-server:$SHA
docker push ftrisjono/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ftrisjono/multi-server:$SHA
kubectl set image deployments/client-deployment client=ftrisjono/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ftrisjono/multi-worker:$SHA
