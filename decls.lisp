;;; -*- Mode: Lisp; Syntax: Common-Lisp; Package: CLIM-INTERNALS; -*-
;;; ---------------------------------------------------------------------------
;;;     Title: DEFGENERICs and stuff
;;;   Created: 2001-08-12
;;;    Author: Gilbert Baumann <unk6@rz.uni-karlsruhe.de>
;;;   License: LGPL (See file COPYING for details).
;;; ---------------------------------------------------------------------------
;;;  (c) copyright 2001,2002 by Gilbert Baumann

;;; This library is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU Library General Public
;;; License as published by the Free Software Foundation; either
;;; version 2 of the License, or (at your option) any later version.
;;;
;;; This library is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; Library General Public License for more details.
;;;
;;; You should have received a copy of the GNU Library General Public
;;; License along with this library; if not, write to the
;;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;;; Boston, MA  02111-1307  USA.

(in-package :clim-internals)

;;;; Early special variables

(defvar *application-frame* nil)

;;; This is just an ad hoc list. Would it be a good idea to include all
;;; (exported) generic functions here? --GB
;;;
;;; YES!  -- CSR
(defgeneric point-x (point))
(defgeneric point-y (point))

(defgeneric transform-region (transformation region))

;;;; 8.1
(defgeneric process-next-event (port &key wait-function timeout))

;;;; 8.3.4 Associating a Medium with a Sheet

;;;; 8.3.4.1 Grafting and Degrafting of Mediums

;; with-sheet-medium (medium sheet) &body body [Macro]
;; with-sheet-medium-bound (sheet medium) &body body [Macro]

(defgeneric sheet-medium (sheet))
(defgeneric medium-sheet (medium))
(defgeneric medium-drawable (medium))
(defgeneric port (medium))

;;;; 8.3.4.1 Grafting and Degrafting of Mediums

(defgeneric allocate-medium (port sheet))
(defgeneric deallocate-medium (port medium))
(defgeneric make-medium (port sheet))
(defgeneric engraft-medium (medium port sheet))
(defgeneric degraft-medium (medium port sheet))

;; 8.4.1 Repaint Protocol Functions

(defgeneric queue-repaint (sheet repaint-event))
(defgeneric handle-repaint (sheet region))
(defgeneric repaint-sheet (sheet region))

;; 9 Ports, Grafts, and Mirrored Sheets

;; (defgeneric portp (object))
;; find-port function

;; 9.4.1 Mirror Functions

(defgeneric sheet-direct-mirror (sheet))
(defgeneric sheet-mirrored-ancestor (sheet))
(defgeneric sheet-mirror (sheet))
(defgeneric realize-mirror (port mirrored-sheet))
(defgeneric destroy-mirror (port mirrored-sheet))
(defgeneric raise-mirror (port sheet))
(defgeneric bury-mirror (port sheet))

;; 9.4.2 Internal Interfaces for Native Coordinates

(defgeneric sheet-native-transformation (sheet))
(defgeneric sheet-native-region (sheet))
(defgeneric sheet-device-transformation (sheet))
(defgeneric sheet-device-region (sheet))
(defgeneric invalidate-cached-transformations (sheet))
(defgeneric invalidate-cached-regions (sheet))

;;; Graphics ops

(defgeneric medium-draw-point* (medium x y))
(defgeneric medium-draw-points* (medium coord-seq))
(defgeneric medium-draw-line* (medium x1 y1 x2 y2))
(defgeneric medium-draw-lines* (medium coord-seq))
(defgeneric medium-draw-polygon* (medium coord-seq closed filled))
(defgeneric medium-draw-rectangle* (medium left top right bottom filled))
(defgeneric medium-draw-ellipse* (medium center-x center-y
				  radius-1-dx radius-1-dy radius-2-dx radius-2-dy
				  start-angle end-angle filled))
(defgeneric medium-draw-circle* (medium center-x center-y radius start-angle end-angle filled))
(defgeneric medium-draw-text* (medium string x y
			       start end
			       align-x align-y
			       toward-x toward-y transform-glyphs))

;;;; 10.2
(defgeneric invoke-with-drawing-options
    (medium continuation &rest drawing-options &key &allow-other-keys))


;;;; 14.5
(defgeneric draw-design
    (medium design
	    &key ink clipping-region transformation line-style line-thickness
	    line-unit line-dashes line-joint-shape line-cap-shape text-style
	    text-family text-face text-size))

;;;; 21.2
(defgeneric invoke-updating-output
    (stream continuation record-type unique-id id-test cache-value cache-test
	    &key fixed-position all-new parent-cache))

;;;; 24.4
(defgeneric presentation-replace-input
    (stream object type view
	    &key buffer-start rescan query-identifier for-context-type))

;;;; 28.3
(defgeneric frame-find-innermost-applicable-presentation
    (frame input-context stream x y &key event))

;;;; 28.4
(defgeneric default-frame-top-level
    (frame &key command-parser command-unparser partial-command-parser prompt))
(defgeneric read-frame-command (frame &key stream))
(defgeneric run-frame-top-level (frame &key &allow-other-keys))
(defgeneric command-enabled (command-name frame))
(defgeneric (setf command-name) (enabled command-name frame))

;;;; 28.5
(defgeneric note-command-enabled (frame-manager frame command-name))
(defgeneric note-command-disabled (frame-manager frame command-name))

;;;; 29.2
;;;;
;;;; FIXME: should we have &key &allow-other-keys here, to cause
;;;; initarg checking?  Probably.
(defgeneric make-pane-1 (realizer frame abstract-class-name &rest initargs))

;;;; 29.2.2 Pane Properties

(defgeneric pane-frame (pane))
(defgeneric pane-name (pane))
(defgeneric pane-foreground (pane))
(defgeneric pane-background (pane))
(defgeneric pane-text-style (pane))

;;;; 29.3.3 Scroller Pane Classes

(defgeneric pane-viewport (pane))
(defgeneric pane-viewport-region (pane)) 
(defgeneric pane-scroller (pane)) 
(defgeneric scroll-extent (pane x y)) 

;;;; 29.3.4 The Layout Protocol

;; (define-protocol-class space-requirement ()) 

;; make-space-requirement &key (width 0) (max-width 0) (min-width 0) (height 0) (max-height 0) (min-height 0) [Function]

(defgeneric space-requirement-width (space-req))
(defgeneric space-requirement-min-width (space-req))
(defgeneric space-requirement-max-width (space-req))
(defgeneric space-requirement-height (space-req))
(defgeneric space-requirement-min-height (space-req))
(defgeneric space-requirement-max-height (space-req))
(defgeneric space-requirement-components (space-req))

;; space-requirement-combine function sr1 sr2 [Function]
;; space-requirement+ sr1 sr2 [Function]
;; space-requirement+* space-req &key width min-width max-width height min-height max-height [Function]

(defgeneric compose-space (pane &key width height))
(defgeneric allocate-space (pane width height))
(defgeneric change-space-requirements
    (pane &rest space-req-keys &key resize-frame width height
          min-width min-height max-width max-height))
(defgeneric note-space-requirements-changed (sheet pane))
;; changing-space-requirements (&key resize-frame layout) &body body [Macro]

;;;; 29.4.4 CLIM Stream Pane Functions

(defgeneric window-clear (window))
(defgeneric window-refresh (window))
(defgeneric window-viewport (window))
(defgeneric window-erase-viewport (window))
(defgeneric window-viewport-position (window))
;; (defgeneric (setf* window-viewport-position) (x y window))

;;;;
(defgeneric gadget-value (gadget))
(defgeneric (setf gadget-value) (new-value gadget &key invoke-callback))
(defgeneric gadget-min-value (gadget))
(defgeneric gadget-max-value (gadget))
(defgeneric (setf gadget-max-value) (new-value gadget))
(defgeneric (setf gadget-min-value) (new-value gadget))
(defgeneric (setf scroll-bar-thumb-size) (new-value scroll-bar))
(defgeneric gadget-orientation (gadget))
(defgeneric gadget-client (gadget))

;;;

(defgeneric medium-foreground (medium))
(defgeneric medium-background (medium))
(defgeneric medium-ink (medium))
(defgeneric medium-transformation (medium))
(defgeneric medium-clipping-region (medium))
(defgeneric medium-line-style (medium))
(defgeneric medium-text-style (medium))
(defgeneric medium-default-text-style (medium))
(defgeneric text-size (medium string &key text-style start end)
  (:documentation
   "Computes the \"cursor motion\" in device units that would take
place if STRING were output to MEDIUM starting at position (0,0).

Returns total width, total height, final x cursor position, final y
cursor position, baseline."))

(defgeneric text-style-mapping (port text-style &optional character-set))

(defgeneric (setf medium-foreground) (new-value medium))
(defgeneric (setf medium-background) (new-value medium))
(defgeneric (setf medium-ink) (new-value medium))
(defgeneric (setf medium-transformation) (new-value medium))
(defgeneric (setf medium-clipping-region) (new-value medium))
(defgeneric (setf medium-line-style) (new-value medium))
(defgeneric (setf medium-text-style) (new-value medium))
(defgeneric (setf medium-default-text-style) (new-value medium))

(defgeneric (setf text-style-mapping)
    (mapping port text-style &optional character-set))
(defgeneric medium-miter-limit (medium)
  (:documentation
   "If LINE-STYLE-JOINT-SHAPE is :MITER and the angle between two
   consequent lines is less than the values return by
   MEDIUM-MITER-LIMIT, :BEVEL is used instead."))
(defgeneric line-style-effective-thickness (line-style medium)
  (:documentation
   "Returns the thickness in device units of a line,
rendered on MEDIUM with the style LINE-STYLE."))

;;;

(defgeneric sheet-grafted-p (sheet))
(defgeneric graft-width (graft &key units))
(defgeneric graft-height (graft &key units))
(defgeneric graft-units (graft))

(defgeneric text-style-character-width (text-style medium char))
;; fall back, where to put this?
(defmethod text-style-character-width (text-style medium char)
  (text-size medium char :text-style text-style))

;; Since the declaim form for functions looks clumsy and is
;; syntax-wise different from defun, we define us a new declfun, which
;; fixes this.

(defmacro declfun (name lambda-list)
  `(declaim (ftype (function
                    ,(let ((q lambda-list)
                           res)
                          (do () ((or (null q)
                                      (member (car q) '(&optional &rest &key))))
                            (push 't res)
                            (pop q))
                          (when (eq (car q) '&optional)
                            (push '&optional res)
                            (pop q)
                            (do () ((or (null q)
                                        (member (car q) '(&rest &key))))
                              (push 't res)))
                          (when (eq (car q) '&rest)
                            (push '&rest res)
                            (pop q)
                            (push 't res)
                            (pop q))
                          (when (eq (car q) '&key)
                            (push '&key res)
                            (pop q)
                            (do () ((or (null q)
                                        (member (car q) '(&allow-other-keys))))
                              (push (list (intern (string (if (consp (car q))
                                                              (if (consp (caar q))
                                                                  (caaar q)
                                                                  (caar q))
                                                              (car q)))
                                                  :keyword)
                                          't)
                                    res)
                              (pop q)))
                          (when (eq (car q) '&allow-other-keys)
                            (push '&allow-other-keys res)
                            (pop q))
                          (reverse res))
                    t)
             ,name)))

(declfun draw-rectangle (sheet point1 point2
                               &rest args
                               &key (filled t)
                               ink clipping-region transformation line-style line-thickness
                               line-unit line-dashes line-joint-shape))

(declfun draw-rectangle* (sheet x1 y1 x2 y2
                                &rest args
                                &key (filled t)
                                ink clipping-region transformation line-style line-thickness
                                line-unit line-dashes line-joint-shape))

;;; "exported" from a port

(defgeneric mirror-transformation (port mirror))
(defgeneric port-set-sheet-region (port sheet region))
(defgeneric port-set-sheet-transformation (port sheet region))
(defgeneric port-text-style-mappings (port))
(defgeneric port-lookup-mirror (port sheet))
(defgeneric port-register-mirror (port sheet mirror))
(defgeneric port-allocate-pixmap (port sheet width height))
(defgeneric port-deallocate-pixmap (port pixmap))
(defgeneric port-mirror-width (port sheet))
(defgeneric port-mirror-height (port sheet))
(defgeneric port-enable-sheet (port sheet))
(defgeneric port-disable-sheet (port sheet))
(defgeneric port-pointer (port))

;;;

;; Used in stream-input.lisp, defined in frames.lisp
(defgeneric frame-event-queue (frame))

;;; Used in presentations.lisp, defined in commands.lisp

(defgeneric presentation-translators (command-table))

(defgeneric stream-default-view (stream))

;;; ----------------------------------------------------------------------

(defgeneric output-record-basline (record)
  (:documentation
   "Returns two values: the baseline of an output record and a boolean
indicating if this baseline is definitive. McCLIM addition."))

#||

Further undeclared functions

  FRAME-EVENT-QUEUE FRAME-EXIT PANE-FRAME
  ALLOCATE-SPACE COMPOSE-SPACE FIND-INNERMOST-APPLICABLE-PRESENTATION 
  HIGHLIGHT-PRESENTATION-1 PANE-DISPLAY-FUNCTION PANE-DISPLAY-TIME PANE-NAME 
  PRESENTATION-OBJECT PRESENTATION-TYPE SPACE-REQUIREMENT-HEIGHT 
  SPACE-REQUIREMENT-WIDTH THROW-HIGHLIGHTED-PRESENTATION WINDOW-CLEAR

  (SETF GADGET-MAX-VALUE) (SETF GADGET-MIN-VALUE) (SETF SCROLL-BAR-THUMB-SIZE) 
  SLOT-ACCESSOR-NAME::|CLIM-INTERNALS CLIENT slot READER| DRAW-EDGES-LINES* 
  FORMAT-CHILDREN GADGET-VALUE MAKE-MENU-BAR TABLE-PANE-NUMBER 
  MEDIUM WITH-GRAPHICS-STATE
  PORT-MIRROR-HEIGHT PORT-MIRROR-WIDTH TEXT-STYLE-CHARACTER-WIDTH
  FIND-INNERMOST-APPLICABLE-PRESENTATION HIGHLIGHT-PRESENTATION-1 
  PRESENTATION-OBJECT PRESENTATION-TYPE THROW-HIGHLIGHTED-PRESENTATION
  FORMAT-CHILDREN TABLE-PANE-NUMBER TEXT-STYLE-CHARACTER-WIDTH
  PORT-MIRROR-HEIGHT PORT-MIRROR-WIDTH SCROLL-EXTENT TEXT-STYLE-CHARACTER-WIDTH
  FRAME-EVENT-QUEUE FRAME-EXIT PANE-FRAME
  ALLOCATE-SPACE COMPOSE-SPACE FIND-INNERMOST-APPLICABLE-PRESENTATION 
  HIGHLIGHT-PRESENTATION-1 PANE-DISPLAY-FUNCTION PANE-DISPLAY-TIME PANE-NAME 
  PRESENTATION-OBJECT PRESENTATION-TYPE SPACE-REQUIREMENT-HEIGHT 
  SPACE-REQUIREMENT-WIDTH THROW-HIGHLIGHTED-PRESENTATION WINDOW-CLEAR
  (SETF GADGET-MAX-VALUE) (SETF GADGET-MIN-VALUE) (SETF SCROLL-BAR-THUMB-SIZE) 
  SLOT-ACCESSOR-NAME::|CLIM-INTERNALS CLIENT slot READER| DRAW-EDGES-LINES* 
  FORMAT-CHILDREN GADGET-VALUE MAKE-MENU-BAR TABLE-PANE-NUMBER 

||#
