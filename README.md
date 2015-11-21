# Overview

 Filename:     cacheMatrix.R

 Functions:    makeCacheMatrix
               cacheSolve

 Author:       Bjoern W. Steffens
 Date:         2015-11-21
 Version:      1.1

 Comments:     The code has been extensively
               commented for any reader to be able to
               understand my thinking. All these comments
               are also there for me to be able to understand
               what was going on next time when I look at this
               to remind me what is going on under the hood
               here.

 Test Instructions:

 > mm <- makeCacheMatrix (matrix(2:5,nrow=2,ncol=2))
 
 MC - Entering the function at the top creating a new object ...
 
 > mm$getinv()
 
 MC - Return the inverted matrix ...
 
 NULL
 
 > cacheSolve(mm)
 
 CS - Entering cachemean function ...
 
 MC - Return the inverted matrix ...
 
 CS - Calculating the mean ...
 
 MC - Return the matrix ...
 
 MC - Allocate the inverted matrix ...
 
 CS - Return the inverted matrix ...
 
 [,1] [,2]
 
 [1,] -2.5    2
 
 [2,]  1.5   -1
 
 > mm$get()
 
 MC - Return the matrix ...
 
 [,1] [,2]
 
 [1,]    2    4
 
 [2,]    3    5
 
 ========================================================================

# makeCacheMatrix

 ========================================================================
 Function:     makeCacheMatrix

 Purpose:      Create a list of functions needed to store the 
               matrix itself and the inverted matrix
               manufactured by cacheSolve
 ========================================================================
makeCacheMatrix <- function(x = matrix()) {
    
    message("MC - Entering the function at the top creating a new object ...")
    
     When you enter the function initiating a new matrix
     the invert is set to null. When you use the "function"
     defined this value is not touched. You need to think
     of the "object" as alive and you set and get properties
     from it when it is alive. Kind of different to 
     traditional coding. I have changed the name if the variable
     to make it a little bit cleared what it actually represents.
    v_invert <- NULL
    
     Pass in a complete inverted matrix and override
     anything present.
     The <<- refers to the variable in the "global"
     envrironment and what was passed into it.
     When you "override" with a new one
     you clear out the inverted one because
     that has yet to happen with the
     cacheSolve function
    set <- function(y) {
        message("MC - Allocating a new matrix ...")
        x <<- y
        v_invert <<- NULL
    }
    
     Simply return the matrix that was passed to
     the function.
    get <- function() {
        message("MC - Return the matrix ...")
        x
    }
    
     Here is where the inverted matrix is allocated
     by the cacheSolve function. The y is passed in 
     as a variable from the external (<<-) environment
     and that is what you need to assign to v_invert.
    setinv <- function(mean) {
        message("MC - Allocate the inverted matrix ...")
        v_invert <<- mean
    }
    
     Return the inverted matrix. If it has not been allocated to
     v_invert by cacheSolve, cacheSolve will see it as NULL and
     calculate it.
    getinv <- function() {
        message("MC - Return the inverted matrix ...")
        v_invert
    }
    
     Return the list of functions
    list(set = set, get = get, setinv = setinv, getinv = getinv)
    
}

# cacheSolve

 ========================================================================
 Function:     cacheSolve

 Purpose:      Calculate and assign the inverted matrix
               of the object passed in. If the inverse
               has been calculated already, meaning not
               necessarily the correct one, just return
               what is available in the main object structure.
 ========================================================================
    cacheSolve <- function(x, ...) 
      
        message("CS - Entering cachemean function ...")
        
         Retrive the "cached" inverted matrix
        v_invert <- x$getinv()
        
         If it exist v_invert != NULL and
         can be returned. You could add a number
         of tests here to ensure it is actaully a 
         matrix etc.
        if(!is.null(v_invert)) {
            message("CS - Getting cached data ...")
             Stop here, no further processing
             is required and return v_invert
            return(v_invert)
        }
        
         Start calculating the inverted matrix using the 
         solve function. Once completed allocate the inverted 
         matrix to x
        message("CS - Calculating the mean ...")
        v_tmp <- x$get()
        v_invert <- solve(v_tmp, ...)
        x$setinv(v_invert)
        
        message("CS - Return the inverted matrix ...")
        v_invert
        
    }



