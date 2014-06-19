## This pair of functions stores a solved inverse matrix and calls the 
## stored inverse rather than recalculating it.

## Ben Zimmerman 6/19/2014

## makeCacheMatrix is a function that takes a nonsingular square matrix and
## saves the matrix and its inverse 

## To use this function store the function in a variable
## (e.g. a <- makeCacheMatrix() ), then set the square, invertible matrix
## (e.g. a$set(matrix(rnorm(16),4,4))

makeCacheMatrix <- function(x = matrix()) {
	
## allocate space for the solved matrix
	m <- NULL

## now this function sets up several functions that can be used by cacheSolve 
## to store and find a previously solved matrix inverse.


## set allows you to set the actual matrix that you'll be using
	set <- function(y) {
		x<<-y
		m<<-NULL
	}

## get calls up the matrix that you're using

	get <- function() x

## setinverse sets replaces the the NULL in m with the solution of the inverse

	setinverse <- function(solve) m <<- solve

## getinverse will be used to look up an existing inverse matrix;
## the function simply calls m, so if m has not been set yet, then m = NULL
	
	getinverse <- function() m
	
## The list below is a special "matrix", containing the functions defined above
## in order to set a matrix, get the matrix, set the inverse matrix, and
## get the inverse matrix

	list(set=set, get=get,
	setinverse = setinverse,
	getinverse = getinverse)
}


## The following function solves the inverse of the special "matrix"
## created with the above function, after checking to see if the inverse 
## has already been calculated. If it has been calculated, the function calls
## the inverse from the cache rather than computing it again. If it hasn't 
## been calculated yet, the function solves the inverse and then sets the 
## value of the inverse matrix in the cache via the setinverse function.

cacheSolve <- function(x=matrix(), ...) {
        ## Return a matrix that is the inverse of 'x'

## Uses "getinverse" defined above to look for an existing inverse matrix
	m <- x$getinverse()
	
## m is NULL if the matrix has not been solved. This looks to see if m is not
## NULL (and thus already solved). If the matrix already has an inverse, then 
## the message is printed along with the inverse matrix.

	if(!is.null(m)){
		message("getting stored inverse")
		return(m)
	}
## If the inverse matrix has not been solved yet, then grab the matrix using
## the get function defined in makeCacheMatrix

	invertible_matrix <- x$get()

## solve the inverse of the matrix

	m <- solve(invertible_matrix,...)

## Use the setinverse function defined in makeCacheMatrix to set the inverse
## matrix in the cache

	x$setinverse(m)

## print the inverse matrix
	m
}


}
