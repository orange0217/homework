kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd admin initial-password -n argocd
argocd cluster add default --cluster-endpoint=config2.yaml --kubeconfig=config2.yaml --name=k8s-2