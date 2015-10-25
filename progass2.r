## Caching the Inverse of a Matrix

## Matrix inversion is usually a costly computation and there may be some benefit to 
## caching the inverse of a matrix rather than computing it repeatedly  

## MakeCacheMatrix: creates a special "matrix" object that can cache its inverse.


makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    get<- function() x
    setinv<- function(inverse) i<<- inverse
    getinv<- function() i
    list(set=set, 
         get=get,
         get<- function() x, 
         setinv= setinv, 
         getinv= getinv)
}


## cacheSolve: This function computes the inverse of the special "matrix" returned 
## by makeCacheMatrix above. If the inverse has already been calculated (and the 
## matrix has not changed), then cacheSolve should retrieve the inverse from the 
## cache.
## Computing the inverse of a square matrix can be done with the solve function in R. 
## For example, if X is a square invertible matrix, then solve(X) returns its 
## inverse.


cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    i<- x$getinv()
    if (!is.null(i)) {
        message("getting cahed data")
        return(i)
        
    }
    matrx<- x$get()
    i<- solve(matrx,...)
    x$setinv(i)
    i
}
