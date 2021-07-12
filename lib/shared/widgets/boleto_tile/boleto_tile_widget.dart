import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:payflow/modules/delete_boleto/delete_boleto_controller.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class BoletoTileWidget extends StatefulWidget {
  final BoletoModel data;

  BoletoTileWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _BoletoTileWidgetState createState() => _BoletoTileWidgetState();
}

class _BoletoTileWidgetState extends State<BoletoTileWidget> {
  final controller = DeleteBoletoController();

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actions: [
          IconSlideAction(
            caption: 'Close',
            color: Colors.black45,
            icon: Icons.close,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                      "Deseja realmente excluir o boleto - ${widget.data.name}?"),
                  content: Text("${widget.data.name}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.delBoleto(
                            widget.data.name,
                            widget.data.dueDate,
                            widget.data.value,
                            widget.data.barcode);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                  elevation: 24.0,
                  backgroundColor: Colors.orange,
                ),
              );

              setState(() {});
            },
          ),
        ],
        actionExtentRatio: 0.25,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          title: Text(
            widget.data.name!,
            style: TextStyles.titleListTile,
          ),
          subtitle: Text(
            "Vence em ${widget.data.dueDate}",
            style: TextStyles.captionBody,
          ),
          trailing: Text.rich(
            TextSpan(
              text: "R\$",
              style: TextStyles.trailingRegular,
              children: [
                TextSpan(
                  text: "${widget.data.value!.toStringAsFixed(2)}",
                  style: TextStyles.trailingBold,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
