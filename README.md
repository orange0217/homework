kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

argocd admin initial-password -n argocd
argocd cluster add default --cluster-endpoint=config2.yaml --kubeconfig=config2.yaml --name=k8s-2

训练营课程大作业
使用 Terraform 开通一台腾讯云 CVM, 安装 K3s(集群 1), 并在集群 1 内安装 Jenkins、Argo CD
书写 Terraform lac 代码: 开通两台腾讯云 CVM, 分别安装 K3s(集群 2、集群 3), 并实现以下要求:
使用集群 1 作为 Terraform Kubernetes backend 后端存储
将 laC 源码存储在 GitHub 代码仓库中
在集群 1 的 Jenkins 中配置流水线, 实现在 lac 代码变更时自动触发变更 (Jenkinsfile)
在集群 1 的 Argo CD 实例中添加集群 2、3
使用一个 ApplicationSet +List Generators 在集群 2、集群 3 内的 default 命名空间下同时部署示例应用 Bookinfo(Helm Chart 源码见: iac/lastwork/bookinfo)
示例应用部署完成后，实现以下架构： assets/img.png
备注
这是一个理想的多云灾备部署场景, 集群 1、2、3 可能分别部署在不同云厂商。集群 1 的 Proxy 作为流量入口对外提供服务，对部署在集群 2 和集群 3 的无状态示例应用 Bookinfo 做负载均衡。



argocd 配置域名后不能访问
在参数里添加 --insecure
或者在 ingress 里自动生成证书，注意要添加 annotations

cert-manager 部署不成功
需要手动部署crd资源