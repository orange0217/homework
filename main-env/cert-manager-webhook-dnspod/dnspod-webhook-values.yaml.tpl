groupName: cert-manager.io # 写一个标识 group 的名称，可以任意写

secrets: 
  apiID: ${secret_id}
  apiToken: ${secret_key}

clusterIssuer:
  enabled: true # 自动创建出一个 ClusterIssuer
  email: your@email.com # 填写您的邮箱地址
