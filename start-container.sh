#bash
docker run -v $HOME/.apigee-secure:/root/.apigee-secure:ro \
   -v $(pwd)/resources:/apigee-workspace/apigee-helm/resources:ro \
   -v $(pwd)/utils:/apigee-workspace/apigee-helm/utils:ro \
   -v $(pwd)/molecule:/apigee-workspace/apigee-helm/molecule:rw \
   -v $(pwd)/work_dir:/apigee-workspace/apigee-helm/work_dir:rw \
   -v $HOME/.config:/root/.config/gcloud:rw \
   -ti \
   apigee-workspace:v1.0 bash
