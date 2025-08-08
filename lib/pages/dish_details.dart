import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/models.dart';
import '../utils/cart_provider.dart';

class DishDetailsDialog extends StatefulWidget {
  final Dish dish;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final Function(String) onAddComment;

  DishDetailsDialog({
    required this.dish,
    required this.onLike,
    required this.onDislike,
    required this.onAddComment,
  });

  @override
  _DishDetailsDialogState createState() => _DishDetailsDialogState();
}

class _DishDetailsDialogState extends State<DishDetailsDialog> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.60,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 190,
                width: double.infinity,
                child: Image.asset(
                  widget.dish.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.dish.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          '${widget.dish.price.toInt()} DH',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.dish.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            widget.onLike();
                            setState(() {});
                          },
                          icon: Icon(Icons.thumb_up, size: 16),
                          label: Text('${widget.dish.likes}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            widget.onDislike();
                            setState(() {});
                          },
                          icon: Icon(Icons.thumb_down, size: 16),
                          label: Text('${widget.dish.dislikes}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (_commentController.text.trim().isNotEmpty) {
                              widget.onAddComment(_commentController.text.trim());
                              _commentController.clear();
                              setState(() {});
                            }
                          },
                          icon: Icon(Icons.send, color: AppColors.green),
                        ),
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    if (widget.dish.comments.isNotEmpty)
                      Column(
                        children: widget.dish.comments.map((comment) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.author,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.green,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  comment.text,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'No comments yet',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// --- Add to Cart Button ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton.icon(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addToCart(widget.dish);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.dish.name} added to cart')),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                label: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            /// --- Close Button ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
