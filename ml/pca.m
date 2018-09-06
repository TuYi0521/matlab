data = load('wine.data')
[row,col] = size(data)
data = zscore(data)

covariance = cov(data)

[eigenvector, eigenvalue] = eig(covariance)
[eigenvalue, index] =sort(diag(eigenvalue),'descend');

plot(log(eigenvalue),'o')

k = 2
matrix_A = eigenvector(:,index(1:k))
matrix_A

new_data = data * matrix_A
recons_data = new_data * matrix_A'



