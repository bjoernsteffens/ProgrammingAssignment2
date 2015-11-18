# ========================================================================
## Put comments here that give an overall description of what your
## functions do
# ========================================================================


## mm <- makeCacheMatrix (matrix(1:4,nrow=2,ncol=2))

# ========================================================================
# Function :: cacheSove
#
# This function takes a matrix x with any rows||cols and returns 
# the inverted matrix b< reversing the rows||cols.
# ========================================================================
cacheSolve <- function(x, ...) {
    
    # initiate the inverse matrix of x with NAs
    m_tmp <- matrix(NA,nrow=ncol(x), ncol=nrow(x))
    
    v_row = 1
    v_col = 1
    
    # Loop through all the columns of x in reverse order
    for ( k in ncol(x):1) {
        
        # Loop through all the rows of x in reverse order
        # and assign the inverted value to m_tmp
        #message("Next column ...")
        
        v_row = 1
        for ( r in nrow(x):1) {
            message("Next row ...")
            # do the magic here, simply swap the values
            m_tmp[k,r] <- x[v_row,v_col]
            #m_tmp[k,r] <- x[r,k]
            #message(v_col)
            #message(v_row)
            v_row <- v_row + 1
        }
        v_col <- v_col + 1
    }
    m_tmp
}

# ========================================================================
# Function :: makeCacheMatrix
#
# This function takes a matrix x with any rows||cols and returns 
# the inverted matrix b< reversing the rows||cols.
# ========================================================================
makeCacheMatrix <- function ( x = matrix, ...) {
    
    # assign the new matrix passed in and return it.
    set <- function(y) {
        message("Assigning a new matrix ...")
        x <<- y
    }
    get <- function() x
    setinv <- function(y) {
        message("Assigning a new inverted matrix ...")
        x <<- y
    } 
    getinv <- function() {
        message("Get the invert of the matrix ...")
        x <- cacheSolve(x)
        x
    }
    
    list (set = set, get = get, setinv = setinv, getinv = getinv)
}



